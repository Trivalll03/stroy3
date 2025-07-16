import 'dart:ui';

import 'package:admin_app/api/entity/enums/UserRole.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:motion_toast/motion_toast.dart';

//192.168.0.11
//45.67.35.206
String ip = "86.104.73.108";
String uid = "";
String name = "";
String surname = "";
String? image;
Color mainColor = const Color(0xff317EFA);
Color border = const Color(0xffD9D9D9);

String getUserPhoto() {
  if (image != null && image!.isNotEmpty) {
    return 'http://$ip:8080/api/v1/file/image/${image}';
  } else {
    return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnGZWTF4dIu8uBZzgjwWRKJJ4DisphDHEwT2KhLNxBAA&s';
  }
}

String getChatNameByDefaultName(String name) {
  switch (name) {
    case "svar":
      return "Сварщики";
    case "bet":
      return "Бетонщики";
    case "bul":
      return "Бульдозерист";
    case "meb":
      return "Мебельщики";
    case "razn":
      return "Разнорабочий";
    case "sles":
      return "Слесарь";
    case "proect":
      return "Проектировщик";
    case "gaz":
      return "Газовщик";
    case "stec":
      return "Стекольщик";
    case "park":
      return "Паркетчик";
    case "el":
      return "Электрики";
    case "vent":
      return "Вентиляционщики";
    case "trash":
      return "Вывоз строительного мусора";
    case "tok":
      return "Токарь";
    case "frez":
      return "Фрезеровщики";
    case "mal":
      return "Маляр штукатур";
    case "zem":
      return "Землекоп";
    case "obl":
      return "Облицовщики";
    case "stol":
      return "Столяры";
    case "geo":
      return "Геодезист";
    case "plot":
      return "Плотники";
    case "san":
      return "Сантехники";
    case "strop":
      return "Стропальщики";
    case "kran":
      return "Крановщики";
    case "cum":
      return "Каменщики";
    case "pech":
      return "Печники";
    case "mon":
      return "Монтажники";
    case "krov":
      return "Кровельщики";
    case "otd":
      return "Отделочники";
    case "moto":
      return "Моторист";
    case "other":
      return "Другое";
    case "global":
      return "Общий";
    default:
      return "Не найдено";
  }
}

String getRole(UserRole role) {
  switch (role) {
    case UserRole.ADMIN:
      return "АДМИНИСТРАТОР";
    case UserRole.MANAGER:
      return "МЕНЕДЖЕР";
    case UserRole.SPECIALIST:
      return "СПЕЦИАЛИСТ";
    case UserRole.USER:
      return "ПОЛЬЗОВАТЕЛЬ";
  }
}

String getPhoto(String? image) {
  if (image != null && image.isNotEmpty) {
    return 'http://$ip:8080/api/v1/file/image/$image';
  } else {
    return 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSnGZWTF4dIu8uBZzgjwWRKJJ4DisphDHEwT2KhLNxBAA&s';
  }
}

String getStoryPhoto(String image) {
  return 'http://$ip:8080/api/v1/storis/photo/$image';
}

String getStoryVideo(String video) {
  return 'http://$ip:8080/api/v1/storis/video/$video';
}

void displayError(String error, BuildContext context) {
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
