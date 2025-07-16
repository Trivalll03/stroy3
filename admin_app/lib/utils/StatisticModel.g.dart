// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'StatisticModel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StatisticModel _$StatisticModelFromJson(Map<String, dynamic> json) =>
    StatisticModel(
      (json['userCount'] as num).toInt(),
      (json['chatCount'] as num).toInt(),
      (json['messagesCount'] as num).toInt(),
      (json['countryCount'] as num).toInt(),
      (json['cityCount'] as num).toInt(),
      (json['allOrders'] as num).toInt(),
      (json['activeOrders'] as num).toInt(),
    );

Map<String, dynamic> _$StatisticModelToJson(StatisticModel instance) =>
    <String, dynamic>{
      'userCount': instance.userCount,
      'chatCount': instance.chatCount,
      'messagesCount': instance.messagesCount,
      'countryCount': instance.countryCount,
      'cityCount': instance.cityCount,
      'allOrders': instance.allOrders,
      'activeOrders': instance.activeOrders,
    };
