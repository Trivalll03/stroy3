import 'dart:math';
import 'dart:ui';

import 'package:app/auth/login_page.dart';
import 'package:app/generated/l10n.dart';
import 'package:app/utils/GlobalsColors.dart';
import 'package:app/utils/GlobalsWidgets.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_chat_bubble/chat_bubble.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ChatPreviewPage extends StatefulWidget {
  final String title;
  const ChatPreviewPage({required this.title, super.key});

  @override
  State<StatefulWidget> createState() => ChatPreviewPageState();
}

class ChatPreviewPageState extends State<ChatPreviewPage> {
  bool click = false;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(5.w),
          child: Column(
            children: [
              SizedBox(
                height: 12.h,
                width: double.maxFinite,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        switch (index) {
                          case 0:
                            return _user(index, "Леонид");
                          case 1:
                            return _user(index, "Артур");
                          case 2:
                            return _user(index, "Мурат");
                          case 3:
                            return _user(index, "Ержан");
                          case 4:
                            return _user(index, "Алексей");
                        }
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(
                          width: 2.w,
                        );
                      },
                      itemCount: 5),
                ),
              ),
              Expanded(
                child: SizedBox(
                  width: double.maxFinite,
                  child: ListView(
                    children: [
                      _message("Привет, нужен специалист завтра в 22:00"),
                      _message("Я могу"),
                      _message("Хорошо, позвоните перед тем как приехать"),
                      _message("Ок."),
                      _message("Добрый день, подскажите хороший инструмент"),
                      _message(
                          "Штиль хорошо делают, всегда им пользовался, никогда не подводил )"),
                    ],
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    click = true;
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 200),
                      child: Container(
                          width: 100.w - 25.w,
                          height: 50,
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E1B26),
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          padding: const EdgeInsets.only(left: 18),
                          child: TextField(
                            onTap: () {
                              setState(() {
                                click = true;
                              });
                            },
                            readOnly: true,
                            style: const TextStyle(color: Colors.white),
                            decoration: InputDecoration(
                              hintText: S.of(context).text,
                              hintStyle: const TextStyle(color: Colors.white54),
                              border: InputBorder.none,
                              prefixIcon: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.photo_camera_outlined,
                                  color: Colors.white,
                                ),
                              ),
                              suffixIcon: IconButton(
                                padding: EdgeInsets.zero,
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.send,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(width: 1.w),
                    IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {},
                      icon: Icon(
                        Icons.mic,
                        size: 8.w,
                      ),
                      color: Colors.black,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        click
            ? GestureDetector(
                onTap: () {
                  setState(() {
                    click = false;
                  });
                },
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(
                      sigmaX: 5,
                      sigmaY: 5,
                    ),
                    child:
                        const Opacity(opacity: 0.01, child: SizedBox.expand()),
                  ),
                ),
              )
            : const SizedBox.shrink(),
        click
            ? InkWell(
                onTap: () {
                  setState(() {
                    click = false;
                  });
                },
                child: SizedBox(
                  height: 100.h,
                  width: 100.w,
                ),
              )
            : SizedBox.shrink(),
        click
            ? GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const LoginPage()));
                },
                child: Center(
                  child: Text(
                    S.of(context).register_please,
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18.sp),
                  ),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }

  Widget _message(String msg) {
    var rnd = Random();
    return GestureDetector(
      onTap: () {
        setState(() {
          click = true;
        });
      },
      child: ChatBubble(
        margin: const EdgeInsets.only(bottom: 20),
        clipper: ChatBubbleClipper1(type: BubbleType.receiverBubble),
        alignment: Alignment.centerLeft,
        backGroundColor: GlobalsColor.blue,
        child: Container(
          width: 70.w,
          height: (rnd.nextInt(10) + 5).h,
          child: Text(
            msg,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }

  Widget _user(int index, String name) {
    return GestureDetector(
      onTap: () {
        setState(() {
          click = true;
        });
      },
      child: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(29), // Image radius
                  child: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.blueAccent,
                      Color(0xffee2a7b),
                      Colors.blueAccent
                    ])),
                  ),
                ),
              ),
              ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(27), // Image radius
                  child: Container(
                    color: Colors.white,
                  ),
                ),
              ),
              ClipOval(
                child: SizedBox.fromSize(
                  size: const Size.fromRadius(25), // Image radius
                  child: Image.network(
                      "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnGZWTF4dIu8uBZzgjwWRKJJ4DisphDHEwT2KhLNxBAA&s",
                      fit: BoxFit.cover),
                ),
              ),
            ],
          ),
          Text(name)
        ],
      ),
    );
  }
}
