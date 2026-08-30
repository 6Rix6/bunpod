import 'package:apple_podcast_api/src/models/rss_podcast_feed.dart';
import 'package:rss_dart/domain/podcast_index/rss_podcast_index_person.dart';
import 'package:rss_dart/domain/rss_itunes_episode_type.dart';
import 'package:rss_dart/dart_rss.dart';

/// Maps a parsed [RssFeed] into this package's [PodcastFeed] model.
///
/// The mapping is tolerant: missing or malformed tags simply stay `null`
/// instead of failing the whole feed.
RSSPodcastFeed mapRssFeed(Uri url, RssFeed feed) {
  final itunes = feed.itunes;
  final podcastIndex = feed.podcastIndex;

  return RSSPodcastFeed(
    url: url,
    title: feed.title,
    link: feed.link,
    description: feed.description ?? itunes?.summary,
    language: feed.language,
    copyright: feed.copyright,
    generator: feed.generator,
    author: itunes?.author ?? feed.author,
    ownerName: itunes?.owner?.name,
    ownerEmail: itunes?.owner?.email,
    imageUrl: itunes?.image?.href ?? feed.image?.url,
    categories: _mergeCategories(feed),
    explicit: itunes?.explicit,
    lastBuildDate: tryParseFeedDate(feed.lastBuildDate),
    guid: podcastIndex?.guid,
    locked: podcastIndex?.locked?.locked,
    lockedOwner: podcastIndex?.locked?.owner,
    funding: (podcastIndex?.funding ?? const [])
        .whereType()
        .map((f) => FeedFunding(url: _tryParseUrl(f.url), description: f.value))
        .toList(),
    persons: _mapPersons(podcastIndex?.persons),
    episodes: feed.items.map(mapRssItem).toList(),
  );
}

/// Maps a single RSS item into a [FeedEpisode].
RSSFeedEpisode mapRssItem(RssItem item) {
  final itunes = item.itunes;
  final podcastIndex = item.podcastIndex;

  return RSSFeedEpisode(
    guid: item.guid,
    title: itunes?.title ?? item.title,
    description: item.description ?? itunes?.summary,
    htmlDescription: item.content?.value,
    link: item.link,
    author: itunes?.author ?? item.author,
    publishedAt: tryParseFeedDate(item.pubDate),
    audioUrl: item.enclosure?.url,
    audioSizeBytes: item.enclosure == null || item.enclosure!.length <= 0
        ? null
        : item.enclosure!.length,
    audioType: item.enclosure?.type,
    duration: itunes?.duration,
    episodeNumber: itunes?.episode,
    seasonNumber: itunes?.season,
    // rss_dart applies the spec default (`full`) when the tag is absent.
    episodeType: switch (itunes?.episodeType) {
      RssItunesEpisodeType.full => RSSFeedEpisodeType.full,
      RssItunesEpisodeType.trailer => RSSFeedEpisodeType.trailer,
      RssItunesEpisodeType.bonus => RSSFeedEpisodeType.bonus,
      null => null,
    },
    imageUrl: itunes?.image?.href,
    chaptersUrl: _tryParseUrl(podcastIndex?.chapters?.url),
    chaptersType: podcastIndex?.chapters?.type,
    transcripts: (podcastIndex?.transcripts ?? const [])
        .whereType()
        .map(
          (t) => FeedTranscript(
            url: _tryParseUrl(t.url),
            type: t.type,
            language: t.language,
          ),
        )
        .toList(),
    persons: _mapPersons(podcastIndex?.persons),
  );
}

// Merges plain RSS and iTunes categories, preserving order and dropping
// duplicates / empty values.
List<String> _mergeCategories(RssFeed feed) {
  final values = <String>[
    ...?feed.itunes?.categories.whereType().map((c) => c.category).whereType(),
    ...feed.categories.map((c) => c.value).whereType(),
  ];
  final seen = <String>{};
  return [
    for (final value in values)
      if (value.trim().isNotEmpty && seen.add(value.trim())) value.trim(),
  ];
}

List<FeedPerson> _mapPersons(List<dynamic>? raw) => (raw ?? const [])
    .whereType<RssPodcastIndexPerson>()
    .map(
      (p) => FeedPerson(
        name: p.name,
        role: p.role,
        group: p.group,
        imageUrl: _tryParseUrl(p.image),
        url: _tryParseUrl(p.link),
      ),
    )
    .toList();

Uri? _tryParseUrl(String? raw) =>
    raw == null || raw.isEmpty ? null : Uri.tryParse(raw);

final RegExp _rfc822Pattern = RegExp(
  r'(\d{1,2})\s+([A-Za-z]{3,})\s+(\d{2,4})\s+(\d{1,2}):(\d{2})(?::(\d{2}))?\s*([+-]\d{4}|[A-Za-z]+)?',
);

const _monthNames = {
  'jan': 1,
  'feb': 2,
  'mar': 3,
  'apr': 4,
  'may': 5,
  'jun': 6,
  'jul': 7,
  'aug': 8,
  'sep': 9,
  'oct': 10,
  'nov': 11,
  'dec': 12,
};

/// Tolerant date parser for feed timestamps.
///
/// Handles ISO-8601 strings as well as the RFC-822 style dates commonly used
/// in RSS feeds (`Tue, 25 Aug 2026 09:00:00 +0900`). Returns UTC date times
/// or `null` when nothing can be parsed.
DateTime? tryParseFeedDate(String? raw) {
  if (raw == null || raw.isEmpty) return null;

  final iso = DateTime.tryParse(raw);
  if (iso != null) return iso.toUtc();

  final match = _rfc822Pattern.firstMatch(raw);
  if (match == null) return null;

  final day = int.tryParse(match.group(1)!);
  final month = _monthNames[match.group(2)!.toLowerCase().substring(0, 3)];
  var year = int.tryParse(match.group(3)!);
  final hour = int.tryParse(match.group(4)!);
  final minute = int.tryParse(match.group(5)!);
  final second = int.tryParse(match.group(6) ?? '0') ?? 0;
  final zone = match.group(7);

  if (day == null || month == null || hour == null || minute == null) {
    return null;
  }
  if (year != null && year < 100) year += 2000;
  if (year == null) return null;

  var offsetInMinutes = 0;
  final zoneOffset = RegExp(r'^([+-])(\d{2})(\d{2})$').firstMatch(zone ?? '');
  if (zoneOffset != null) {
    final sign = zoneOffset.group(1) == '-' ? -1 : 1;
    offsetInMinutes =
        sign *
        (int.parse(zoneOffset.group(2)!) * 60 +
            int.parse(zoneOffset.group(3)!));
  }

  return DateTime.utc(
    year,
    month,
    day,
    hour,
    minute,
    second,
  ).subtract(Duration(minutes: offsetInMinutes));
}
