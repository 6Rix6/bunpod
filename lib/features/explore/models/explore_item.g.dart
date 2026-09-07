// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExploreHost _$ExploreHostFromJson(Map<String, dynamic> json) => ExploreHost(
  name: json['name'] as String,
  color: (json['color'] as num).toInt(),
  channels: (json['channels'] as List<dynamic>)
      .map((e) => Channel.fromJson(e as Map<String, dynamic>))
      .toList(),
  $type: json['runtimeType'] as String?,
);

Map<String, dynamic> _$ExploreHostToJson(ExploreHost instance) =>
    <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'channels': instance.channels,
      'runtimeType': instance.$type,
    };

ExploreCategory _$ExploreCategoryFromJson(Map<String, dynamic> json) =>
    ExploreCategory(
      name: json['name'] as String,
      color: (json['color'] as num).toInt(),
      channels: (json['channels'] as List<dynamic>)
          .map((e) => Channel.fromJson(e as Map<String, dynamic>))
          .toList(),
      $type: json['runtimeType'] as String?,
    );

Map<String, dynamic> _$ExploreCategoryToJson(ExploreCategory instance) =>
    <String, dynamic>{
      'name': instance.name,
      'color': instance.color,
      'channels': instance.channels,
      'runtimeType': instance.$type,
    };
