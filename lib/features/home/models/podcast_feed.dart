import 'package:bunpod/bunpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'podcast_feed.freezed.dart';

@freezed
sealed class PodcastFeed with _$PodcastFeed {
  const factory PodcastFeed({
    required Channel channel,
    required List<Episode> episodes,
  }) = _PodcastFeed;
}
