import 'package:app/api/entity/enums/UserRole.dart';
import 'package:app/auth/login_page.dart';
import 'package:app/auth/register_page.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/utils/GlobalsColors.dart';
import 'package:app/utils/SliderBarMenu.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class SliderBarMenuPreload extends StatelessWidget {
  final Function(String title) onClickItem;
  final String activeTab;
  SliderBarMenuPreload(
      {required this.onClickItem, required this.activeTab, super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: ListView(children: [
      SizedBox(
        height: 2.h,
      ),
      InkWell(
        onTap: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const LoginPage()));
        },
        child: Ink(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Container(
              height: 8.h,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: GlobalsColor.blue),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.next_plan,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 2.w,
                  ),
                  Text(S.of(context).signin,
                      style: TextStyle(
                          fontSize: 16.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.bold))
                ],
              ),
            ),
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
          .map((menu) => SliderMenuItem(
              title: menu.title,
              isSelected: activeTab.contains(menu.title),
              iconData: menu.iconData,
              onTap: onClickItem))
          .toList(),
      SizedBox(
        height: 2.h,
      ),
    ]));
  }
}
