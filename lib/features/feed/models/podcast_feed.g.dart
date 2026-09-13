// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PodcastFeed _$PodcastFeedFromJson(Map<String, dynamic> json) => _PodcastFeed(
  url: json['url'] as String,
  channel: Channel.fromJson(json['channel'] as Map<String, dynamic>),
  episodes: (json['episodes'] as List<dynamic>)
      .map((e) => Episode.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PodcastFeedToJson(_PodcastFeed instance) =>
    <String, dynamic>{
      'url': instance.url,
      'channel': instance.channel,
      'episodes': instance.episodes,
    };
