import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:bunpod/bunpod.dart';

extension PodcastFeedMapper on RSSPodcastFeed {
  Future<PodcastFeed?> toPodcastFeed(String url) async {
    if (imageUrl == null) return null;

    final seed = await ImageColorCache.of(imageUrl!);

    final channel = toChannel(seed: seed, feedUrl: url);
    if (channel == null) return null;

    final eps = episodes
        .map(
          (e) => e.toEpisode(seed: seed, channel: channel),
        )
        .whereType<Episode>()
        .toList();

    return PodcastFeed(url: url, channel: channel, episodes: eps);
  }

  Channel? toChannel({required int seed, required String feedUrl}) {
    if (title == null || ownerName == null || imageUrl == null) {
      return null;
    }

    return Channel(
      feedUrl: feedUrl,
      name: title!,
      host: ownerName!,
      color: seed,
      image: imageUrl!,
      description: description ?? '',
      categories: categories,
    );
  }
}

extension FeedEpisodeMapper on RSSFeedEpisode {
  /// Converts a [FeedEpisode] to an [Episode].
  /// Returns `null` if any required non-nullable fields are missing.
  Episode? toEpisode({
    required int seed,
    required Channel channel,
  }) {
    // Check required non-nullable fields.
    if (guid == null ||
        title == null ||
        publishedAt == null ||
        audioUrl == null ||
        duration == null) {
      return null;
    }

    return Episode(
      guid: guid!,
      bucket: _calculateBucket(publishedAt!),
      channel: channel.name,
      host: channel.host,
      title: title!,
      date: publishedAt!.toIso8601String(),
      color: seed,
      image: channel.image,
      feedurl: channel.feedUrl,
      audioUrl: audioUrl!,
      total: duration!,
      listened: Duration.zero,
    );
  }

  Bucket _calculateBucket(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final targetDate = DateTime(date.year, date.month, date.day);

    final differenceInDays = today.difference(targetDate).inDays;

    if (differenceInDays == 0) {
      return Bucket.today;
    } else if (differenceInDays == 1) {
      return Bucket.yesterday;
    } else if (differenceInDays > 1 && differenceInDays <= 7) {
      return Bucket.thisWeek;
    } else if (date.year == now.year && date.month == now.month) {
      return Bucket.thisMonth;
    } else {
      return Bucket.earlier;
    }
  }
}
