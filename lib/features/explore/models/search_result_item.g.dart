// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_result_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SearchResultItem _$SearchResultItemFromJson(Map<String, dynamic> json) =>
    _SearchResultItem(
      channel: Channel.fromJson(json['channel'] as Map<String, dynamic>),
      feedUrl: json['feedUrl'] as String,
    );

Map<String, dynamic> _$SearchResultItemToJson(_SearchResultItem instance) =>
    <String, dynamic>{'channel': instance.channel, 'feedUrl': instance.feedUrl};
