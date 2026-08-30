import 'package:bunpod/bunpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'podcast_feed.freezed.dart';
part 'podcast_feed.g.dart';

@freezed
sealed class PodcastFeed with _$PodcastFeed {
  const factory PodcastFeed({
    required Channel channel,
    required List<Episode> episodes,
  }) = _PodcastFeed;

  factory PodcastFeed.fromJson(Map<String, dynamic> json) =>
      _$PodcastFeedFromJson(json);
}
