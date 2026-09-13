// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'channel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Channel _$ChannelFromJson(Map<String, dynamic> json) => _Channel(
  localId: (json['localId'] as num).toInt(),
  feedUrl: json['feedUrl'] as String,
  name: json['name'] as String,
  host: json['host'] as String,
  color: (json['color'] as num).toInt(),
  image: json['image'] as String,
  description: json['description'] as String,
  categories:
      (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
);

Map<String, dynamic> _$ChannelToJson(_Channel instance) => <String, dynamic>{
  'localId': instance.localId,
  'feedUrl': instance.feedUrl,
  'name': instance.name,
  'host': instance.host,
  'color': instance.color,
  'image': instance.image,
  'description': instance.description,
  'categories': instance.categories,
};
