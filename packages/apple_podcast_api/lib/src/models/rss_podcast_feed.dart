import 'package:freezed_annotation/freezed_annotation.dart';

part 'rss_podcast_feed.freezed.dart';

/// A parsed podcast RSS feed (`feedUrl` of a [Podcast]).
@freezed
sealed class RSSPodcastFeed with _$RSSPodcastFeed {
  const factory RSSPodcastFeed({
    Uri? url,
    String? title,
    String? link,
    String? description,
    String? language,
    String? copyright,
    String? generator,

    /// Author of the show (`itunes:author`).
    String? author,
    String? ownerName,
    String? ownerEmail,
    String? imageUrl,
    @Default([]) List<String> categories,
    bool? explicit,
    DateTime? lastBuildDate,

    /// Unique global identifier (`podcast:guid`).
    String? guid,

    /// Whether the feed is protected from directory ingestion
    /// (`podcast:locked`).
    bool? locked,
    String? lockedOwner,
    @Default([]) List<FeedFunding> funding,
    @Default([]) List<FeedPerson> persons,
    @Default([]) List<RSSFeedEpisode> episodes,
  }) = _RSSPodcastFeed;
}

/// A funding / donation link (`podcast:funding`).
@freezed
sealed class FeedFunding with _$FeedFunding {
  const factory FeedFunding({
    Uri? url,
    String? description,
  }) = _FeedFunding;
}

/// A person related to a show or an episode (`podcast:person`).
@freezed
sealed class FeedPerson with _$FeedPerson {
  const factory FeedPerson({
    required String name,
    String? role,
    String? group,
    Uri? imageUrl,
    Uri? url,
  }) = _FeedPerson;
}

/// A transcript file reference (`podcast:transcript`).
///
/// The transcript itself is not downloaded; only its location is exposed.
@freezed
sealed class FeedTranscript with _$FeedTranscript {
  const factory FeedTranscript({
    Uri? url,
    String? type,
    String? language,
  }) = _FeedTranscript;
}

/// Type of an episode (`itunes:episodeType`).
///
/// Per the iTunes spec the implicit default is [full].
enum RSSFeedEpisodeType { full, trailer, bonus }

/// A single episode entry inside a [RSSPodcastFeed].
@freezed
sealed class RSSFeedEpisode with _$RSSFeedEpisode {
  const factory RSSFeedEpisode({
    String? guid,
    String? title,
    String? description,

    /// HTML body from `content:encoded`, if present.
    String? htmlDescription,
    String? link,
    String? author,
    DateTime? publishedAt,
    String? audioUrl,
    int? audioSizeBytes,
    String? audioType,
    Duration? duration,
    int? episodeNumber,
    int? seasonNumber,
    RSSFeedEpisodeType? episodeType,
    String? imageUrl,
    Uri? chaptersUrl,
    String? chaptersType,
    @Default([]) List<FeedTranscript> transcripts,
    @Default([]) List<FeedPerson> persons,
  }) = _RSSFeedEpisode;
}
