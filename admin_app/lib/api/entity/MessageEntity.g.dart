// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'MessageEntity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MessageEntity _$MessageEntityFromJson(Map<String, dynamic> json) =>
    MessageEntity(
      id: (json['id'] as num).toInt(),
      content: json['content'] as String,
      type: $enumDecode(_$MessageTypeEnumMap, json['type']),
      chat: json['chat'] == null
          ? null
          : ChatEntity.fromJson(json['chat'] as Map<String, dynamic>),
      user: UserEntity.fromJson(json['user'] as Map<String, dynamic>),
      time: DateTime.parse(json['time'] as String),
    );

Map<String, dynamic> _$MessageEntityToJson(MessageEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'type': _$MessageTypeEnumMap[instance.type]!,
      if (instance.chat case final value?) 'chat': value,
      'user': instance.user,
      'time': instance.time.toIso8601String(),
    };

const _$MessageTypeEnumMap = {
  MessageType.USER: 'USER',
  MessageType.AUDIO: 'AUDIO',
  MessageType.PHOTO: 'PHOTO',
};
