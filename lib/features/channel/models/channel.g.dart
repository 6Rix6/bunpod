// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Channel _$ChannelFromJson(Map<String, dynamic> json) => _Channel(
  name: json['name'] as String,
  host: json['host'] as String,
  color: (json['color'] as num).toInt(),
  image: json['image'] as String,
  description: json['description'] as String,
);

Map<String, dynamic> _$ChannelToJson(_Channel instance) => <String, dynamic>{
  'name': instance.name,
  'host': instance.host,
  'color': instance.color,
  'image': instance.image,
  'description': instance.description,
};
