import 'package:admin_app/api/RestClient.dart';
import 'package:admin_app/auth/code_enter_login_page.dart';
import 'package:admin_app/utils/globals.dart';
import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class LoginPage extends StatefulWidget{
  const LoginPage({super.key});

  @override
  State<StatefulWidget> createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage>{
  String? phone;
  String? password;
  final TextEditingController _phoneController = TextEditingController(text: "+7");

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(() {
      // Не даём стереть +7
      if (!_phoneController.text.startsWith("+7")) {
        _phoneController.text = "+7";
        _phoneController.selection = TextSelection.fromPosition(
          TextPosition(offset: _phoneController.text.length),
        );
      }
      phone = _phoneController.text;
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(5.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Align(
              alignment: Alignment.center,
              child: Image.asset(
                "assets/logo.png",
                fit: BoxFit.fill,
                height: 10.h,
                width: 60.w,
              ),
            ),
            SizedBox(height: 5.h,),
            Text(
              "Вход",
              style: TextStyle(
                color: const Color(0xff317EFA),
                fontSize: 20.sp,
                fontWeight: FontWeight.bold
              ),
            ),
            SizedBox(height: 2.h,),
            Text(
              "Номер телефона",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 1.h,),
            SizedBox(
              height: 8.h,
              child: TextFormField(
                controller: _phoneController,
                onChanged: (value) {
                  phone = value;
                },
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[0-9+]+')),
                  LengthLimitingTextInputFormatter(12), // +7 и 10 цифр
                ],
                decoration: InputDecoration(
                  hintText: "Введите номер телефона",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Color(0xffD9D9D9))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Color(0xffD9D9D9))
                  ),
                ),
              ),
            ),
            SizedBox(height: 2.h,),
            Text(
              "Пароль",
              style: TextStyle(fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 1.h,),
            SizedBox(
              height: 8.h,
              child: TextFormField(
                onChanged: (value){
                  password = value;
                },
                decoration: InputDecoration(
                  hintText: "Введите пароль",
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Color(0xffD9D9D9))
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(9),
                      borderSide: const BorderSide(color: Color(0xffD9D9D9))
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: (){

                },
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  alignment: Alignment.topRight,
                ),
                child: Text(
                  "Забыли пароль?",
                  style: TextStyle(color: const Color(0xff317EFA), fontSize: 14.sp),
                ),
              ),
            ),
            SizedBox(
              width: double.maxFinite,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  backgroundColor: const Color(0xff317EFA),
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5)
                  )
                ),
                onPressed: () {
                  Dio dio = Dio();
                  RestClient client = RestClient(dio);
                  String phoneNumber = _phoneController.text;
                  // Проверяем, чтобы пароль не был пустым
                  if (password == null || password!.isEmpty) {
                    _displayErrorMotionToast("Введите пароль!");
                    return;
                  }
                  print("Отправляется телефон: >$phoneNumber<");
                  print("Отправляется пароль: >$password<");
                  client.adminLogin(phoneNumber, password!).then((value) async {
                    await FirebaseAuth.instance.signInAnonymously();
                    uid = FirebaseAuth.instance.currentUser!.uid;
                    if(context.mounted){
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CodeEnterLoginPage(
                            code: value,
                            phone: phoneNumber,
                          )
                        ),
                        (route) => false
                      );
                    }
                  }).onError((error, stackTrace){
                    // Вот тут максимально подробный вывод ошибки!
                    print("=== ОШИБКА DIO ===");
                    print("DioError: $error");
                    if (error is DioException) {
                      print("Ответ сервера: ${error.response?.data}");
                      debugPrint("Ответ сервера: ${error.response?.data}");
                      _displayErrorMotionToast(
                        error.response?.data?.toString() ?? "Неизвестная ошибка"
                      );
                    } else {
                      print("Другая ошибка: $error");
                      _displayErrorMotionToast("Произошла ошибка: $error");
                    }
                  });
                },
                child: const Text("Войти", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _displayErrorMotionToast(String error) {
    MotionToast.error(
      title: const Text(
        'Ошибка',
        style: TextStyle(
          fontWeight: FontWeight.bold,
        ),
      ),
      description: Text(error),
      barrierColor: Colors.black.withOpacity(0.3),
      width: 300,
      height: 80,
      dismissable: true,
    ).show(context);
  }
}
