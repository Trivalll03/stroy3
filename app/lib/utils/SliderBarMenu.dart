import 'package:app/api/entity/UserEntity.dart';
import 'package:app/api/entity/enums/UserRole.dart';
import 'package:app/auth/login_page.dart';
import 'package:app/auth/register_page.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/pages/profile_page.dart';
import 'package:app/utils/GlobalsColors.dart';
import 'package:app/utils/GlobalsWidgets.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class SliderBarMenu extends StatelessWidget {
  final ValueNotifier imageValue = ValueNotifier(GlobalsWidgets.image);
  final ValueNotifier walletValue = ValueNotifier(GlobalsWidgets.wallet);
  final Function(String title) onClickItem;
  final String activeTab;
  final UserEntity? userEntity;
  SliderBarMenu(
      {required this.onClickItem,
      required this.activeTab,
      this.userEntity,
      super.key});

  @override
  Widget build(BuildContext context) {
    GlobalsWidgets.wallet = userEntity == null ? 0 : userEntity!.wallet;
    return SafeArea(
      child: ListView(
        children: [
          userEntity == null
              ? const SizedBox.shrink()
              : Container(
                  decoration: BoxDecoration(
                      color: GlobalsColor.blue,
                      borderRadius: const BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20))),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 2.h, left: 5.w, right: 5.w, bottom: 5.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .push(MaterialPageRoute(
                                    builder: (context) => ProfilePage(
                                          user: userEntity!,
                                        )))
                                .then((value) {
                              imageValue.value = GlobalsWidgets.image;
                              walletValue.value = GlobalsWidgets.wallet;
                            });
                          },
                          child: Row(
                            children: [
                              ValueListenableBuilder(
                                  valueListenable: imageValue,
                                  builder: (contex, s, values) {
                                    return ClipOval(
                                      child: SizedBox.fromSize(
                                        size: const Size.fromRadius(
                                            25), // Image radius
                                        child: Image.network(
                                            GlobalsWidgets.getUserPhoto(),
                                            fit: BoxFit.cover),
                                      ),
                                    );
                                  }),
                              SizedBox(
                                width: 3.w,
                              ),
                              Flexible(
                                  flex: 1,
                                  fit: FlexFit.tight,
                                  child: SizedBox(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              "${userEntity!.name} ${userEntity!.surname}",
                                              textAlign: TextAlign.start,
                                              style: TextStyle(
                                                  fontSize: 14.sp,
                                                  color: Colors.white),
                                            ),
                                            userEntity!.subscription
                                                ? Text(" [PLUS]",
                                                    textAlign: TextAlign.start,
                                                    style: TextStyle(
                                                        fontSize: 14.sp,
                                                        color: const Color(
                                                            0xff317EFA),
                                                        fontWeight:
                                                            FontWeight.bold))
                                                : const SizedBox.shrink()
                                          ],
                                        ),
                                        userEntity!.role == UserRole.SPECIALIST
                                            ? ValueListenableBuilder(
                                                valueListenable: walletValue,
                                                builder: (_, __, ___) {
                                                  return Row(
                                                    children: [
                                                      Icon(
                                                        Icons.wallet_outlined,
                                                        color: Colors.white,
                                                        size: 5.w,
                                                      ),
                                                      SizedBox(
                                                        width: 1.w,
                                                      ),
                                                      Text(
                                                          "${GlobalsWidgets.wallet.round()} ₸",
                                                          style: TextStyle(
                                                              fontSize: 14.sp,
                                                              color:
                                                                  Colors.white))
                                                    ],
                                                  );
                                                })
                                            : const SizedBox.shrink()
                                      ],
                                    ),
                                  )),
                              SizedBox(
                                width: 3.w,
                              ),
                              Container(
                                height: 10.w,
                                width: 10.w,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    color: Colors.white),
                                child: const Center(
                                  child: Icon(
                                    Icons.notifications_none,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 2.h,
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.location_history,
                              color: Colors.white,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            Text(userEntity!.city.name,
                                style: TextStyle(
                                    fontSize: 14.sp, color: Colors.white))
                          ],
                        )
                      ],
                    ),
                  ),
                ),
          SizedBox(
            height: 2.h,
          ),
          userEntity == null
              ? const SizedBox.shrink()
              : GestureDetector(
                  onTap: () {
                    onClickItem.call(S.of(context).chat);
                  },
                  child: Container(
                    height: 8.h,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: GlobalsColor.blue),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.chat,
                          color: Colors.white,
                        ),
                        SizedBox(
                          width: 2.w,
                        ),
                        Text(S.of(context).chat,
                            style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.white,
                                fontWeight: FontWeight.bold))
                      ],
                    ),
                  ),
                ),
          SizedBox(
            height: 2.h,
          ),
          ...[
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_1.jpg",
                ),
              ),
              S.of(context).page1,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_2.jpg",
                ),
              ),
              S.of(context).page2,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_3.jpg",
                ),
              ),
              S.of(context).page3,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_4.jpg",
                ),
              ),
              S.of(context).page4,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_5.jpg",
                ),
              ),
              S.of(context).page5,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_6.jpg",
                ),
              ),
              S.of(context).page6,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_7.jpg",
                ),
              ),
              S.of(context).page7,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_8.jpg",
                ),
              ),
              S.of(context).page8,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_9.jpg",
                ),
              ),
              S.of(context).page9,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_10.jpg",
                ),
              ),
              S.of(context).page10,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_11.jpg",
                ),
              ),
              S.of(context).page11,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_12.jpg",
                ),
              ),
              S.of(context).page12,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_13.jpg",
                ),
              ),
              S.of(context).page13,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_14.jpg",
                ),
              ),
              S.of(context).page14,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_15.jpg",
                ),
              ),
              S.of(context).page15,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_16.jpg",
                ),
              ),
              S.of(context).page16,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_17.jpg",
                ),
              ),
              S.of(context).page17,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_18.jpg",
                ),
              ),
              S.of(context).page18,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_19.jpg",
                ),
              ),
              S.of(context).page19,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_20.jpg",
                ),
              ),
              S.of(context).page20,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_21.jpg",
                ),
              ),
              S.of(context).page21,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_22.jpg",
                ),
              ),
              S.of(context).page22,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_23.jpg",
                ),
              ),
              S.of(context).page23,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_24.jpg",
                ),
              ),
              S.of(context).page24,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_25.jpg",
                ),
              ),
              S.of(context).page25,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_26.jpg",
                ),
              ),
              S.of(context).page26,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_27.jpg",
                ),
              ),
              S.of(context).page27,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_28.jpg",
                ),
              ),
              S.of(context).page28,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_29.jpg",
                ),
              ),
              S.of(context).page29,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_30.jpg",
                ),
              ),
              S.of(context).page30,
            ),
            Menu(
              ClipRRect(
                borderRadius: BorderRadius.circular(0),
                child: Image.asset(
                  "assets/menu_icon_31.jpg",
                ),
              ),
              S.of(context).page31,
            ),
          ]
              .map((menu) => menu != null
                  ? SliderMenuItem(
                      title: menu.title,
                      isSelected: activeTab.contains(menu.title),
                      iconData: menu.iconData,
                      onTap: onClickItem)
                  : const SizedBox.shrink())
              .toList(),
          Align(
            alignment: Alignment.center,
            child: Text(
              "Наши проекты:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(1.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                GestureDetector(
                  onTap: () {
                    launchUrl(
                        Uri.parse(
                            "https://play.google.com/store/apps/details?id=com.thedeveloper.gnextlogistics"),
                        mode: LaunchMode.externalApplication);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                        height: 20.w,
                        width: 20.w,
                        "https://play-lh.googleusercontent.com/Z4YYTmo2u52iu9ipQJ5RWIrR8AP1o48PWeKTI4U_qP5EX3uyrrQyzlIjwD4ZcmqiLGI=w240-h480-rw"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    launchUrl(
                        Uri.parse(
                            "https://play.google.com/store/apps/details?id=com.thedeveloper.builder_job"),
                        mode: LaunchMode.externalApplication);
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.network(
                        height: 20.w,
                        width: 20.w,
                        "https://play-lh.googleusercontent.com/GYhNpP12Kl595YXG9gLTfdXyUsFPuQ20wMYrUuFQgRR8m0dz-vOcz7b1jXGaHZRhsvw=w240-h480-rw"),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
        ],
      ),
    );
  }
}

class SliderMenuItem extends StatelessWidget {
  final String title;
  final Widget iconData;
  final Function(String)? onTap;
  final bool isSelected;
  const SliderMenuItem(
      {Key? key,
      required this.title,
      required this.iconData,
      required this.isSelected,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSelected) debugPrint("$title $isSelected");
    return ListTile(
        selected: isSelected,
        selectedTileColor: Colors.blue.withOpacity(0.3),
        title: Text(title,
            style: TextStyle(
                color: Colors.black,
                fontSize: 15.sp,
                fontWeight: FontWeight.bold)),
        leading: SizedBox(
          height: 15.w,
          width: 15.w,
          child: iconData,
        ),
        onTap: () => onTap?.call(title));
  }
}

class Menu {
  final Widget iconData;
  final String title;
  Menu(this.iconData, this.title);
}
