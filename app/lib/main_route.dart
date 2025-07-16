import 'dart:developer';
import 'dart:io';

import 'package:app/api/RestClient.dart';
import 'package:app/api/entity/UserEntity.dart';
import 'package:app/api/entity/enums/Categories.dart';
import 'package:app/api/entity/enums/Mode.dart';
import 'package:app/api/entity/enums/OrderMode.dart';
import 'package:app/api/entity/enums/UserRole.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/pages/chats/ChatPage.dart';
import 'package:app/pages/catalog_page.dart';
import 'package:app/pages/search_page.dart';
import 'package:app/pages/search_transportation_page.dart';
import 'package:app/pages/seconds/chat_page.dart';
import 'package:app/pages/seconds/create_cargo.dart';
import 'package:app/pages/seconds/create_order_taxi.dart';
import 'package:app/pages/seconds/create_shop.dart';
import 'package:app/pages/seconds/create_transportation_page.dart';
import 'package:app/pages/seconds/my_taxi_orders.dart';
import 'package:app/pages/transportation_page.dart';
import 'package:app/utils/GlobalsColors.dart';
import 'package:app/utils/GlobalsWidgets.dart';
import 'package:app/utils/SliderBarMenu.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MainRoute extends StatefulWidget {
  const MainRoute({super.key, required this.userEntity});
  final UserEntity userEntity;
  @override
  State<StatefulWidget> createState() => _MainRouteState();
}

class _MainRouteState extends State<MainRoute> {
  int activeTab = 0;
  final GlobalKey<SliderDrawerState> _sliderDrawerKey =
      GlobalKey<SliderDrawerState>();
  final GlobalKey<TransportationPageState> _transportationKey =
      GlobalKey<TransportationPageState>();
  final GlobalKey<CatalogPageState> _shopKey = GlobalKey<CatalogPageState>();
  String selectTab = "";
  List<String> pages = [];
  Mode selectedMode = Mode.CITY;
  Mode selectedModeEv = Mode.CITY;
  File? file;

  @override
  Widget build(BuildContext context) {
    pages = [
      S.of(context).page1,
      S.of(context).page2,
      S.of(context).page3,
      S.of(context).page4,
      S.of(context).page5,
      S.of(context).page6,
      S.of(context).page7,
      S.of(context).page8,
      S.of(context).page9,
      S.of(context).page10,
      S.of(context).page11,
      S.of(context).page12,
      S.of(context).page13,
      S.of(context).page14,
      S.of(context).page15,
      S.of(context).page16,
      S.of(context).page17,
      S.of(context).page18,
      S.of(context).page19,
      S.of(context).page20,
      S.of(context).page21,
      S.of(context).page22,
      S.of(context).page23,
      S.of(context).page24,
      S.of(context).page25,
      S.of(context).page26,
      S.of(context).page27,
      S.of(context).page28,
      S.of(context).page29,
      S.of(context).page30,
      S.of(context).page31,
      "Чат"
    ];
    selectTab = pages[activeTab];
    return Scaffold(
      body: SliderDrawer(
        key: _sliderDrawerKey,
        sliderOpenSize: 80.w,
        appBar: SliderAppBar(
            trailing: Padding(
              padding: EdgeInsets.only(right: 5.w),
              child: FutureBuilder(
                future: SharedPreferences.getInstance(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    bool notify = snapshot.data!.getBool(GlobalsWidgets
                            .chats[getIndex(context, selectTab)]) ??
                        false;
                    log("[${GlobalsWidgets.chats[getIndex(context, selectTab)]}] = [$notify]");
                    if (notify) {
                      return IconButton(
                        onPressed: () async {
                          await snapshot.data!.setBool(
                              GlobalsWidgets
                                  .chats[getIndex(context, selectTab)],
                              false);
                          log("[${GlobalsWidgets.chats[getIndex(context, selectTab)]}] = false");
                          setState(() {});
                        },
                        icon: Icon(Icons.notifications),
                      );
                    } else {
                      return IconButton(
                        onPressed: () async {
                          await snapshot.data!.setBool(
                              GlobalsWidgets
                                  .chats[getIndex(context, selectTab)],
                              true);
                          log("${GlobalsWidgets.chats[getIndex(context, selectTab)]} = true");
                          setState(() {});
                        },
                        icon: Icon(Icons.notifications_off_sharp),
                      );
                    }
                  } else {
                    return const SizedBox.shrink();
                  }
                },
              ),
            ),
            appBarColor: Colors.white,
            appBarPadding:
                EdgeInsets.only(top: MediaQuery.of(context).viewPadding.top),
            appBarHeight: 15.h,
            title: Text(selectTab,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                style:
                    TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w700))),
        slider: SliderBarMenu(
            userEntity: widget.userEntity,
            activeTab: selectTab,
            onClickItem: (title) {
              _sliderDrawerKey.currentState!.closeSlider();
              setState(() {
                activeTab = getIndex(context, title);
              });
            }),
        child: Builder(builder: (context) => _buildWidget(context, selectTab)),
      ),
    );
  }

  int getIndex(BuildContext context, String title) {
    for (int i = 0; i < pages.length; i++) {
      if (pages[i] == title) {
        return i;
      }
    }
    return 0;
  }

  Widget _buildWidget(BuildContext context, String title) {
    if (title.contains("Чат")) {
      return ChatPage(
        user: widget.userEntity,
      );
    }
    return CustomChatPage(
        key: Key("key_$title"),
        history: true,
        showTitle: false,
        title: title,
        subscription: widget.userEntity.subscription,
        chatName: GlobalsWidgets.chats[getIndex(context, title)]);
  }
}
