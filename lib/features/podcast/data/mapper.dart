import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:bunpod/bunpod.dart';
import 'package:flutter/material.dart';

extension PodcastFeedMapper on RSSPodcastFeed {
  Future<PodcastFeed?> toPodcastFeed(String url) async {
    if (imageUrl == null) return null;

    final seed =
        (await getColorsFromNetworkImage(imageUrl!)).firstOrNull ?? Colors.grey;

    final channel = toChannel(seed: seed);
    if (channel == null) return null;

    final eps = episodes
        .map(
          (e) => e.toEpisode(seed: seed, channel: channel),
        )
        .whereType<Episode>()
        .toList();

    return PodcastFeed(url: url, channel: channel, episodes: eps);
  }

  Channel? toChannel({
    required Color seed,
  }) {
    if (title == null || ownerName == null || imageUrl == null) {
      return null;
    }

    return Channel(
      name: title!,
      host: ownerName!,
      color: seed.toARGB32(),
      image: imageUrl!,
      description: description ?? '',
    );
  }
}

extension FeedEpisodeMapper on RSSFeedEpisode {
  /// Converts a [FeedEpisode] to an [Episode].
  /// Returns `null` if any required non-nullable fields are missing.
  Episode? toEpisode({
    required Color seed,
    required Channel channel,
  }) {
    // Check required non-nullable fields.
    if (title == null ||
        publishedAt == null ||
        audioUrl == null ||
        duration == null) {
      return null;
    }

    return Episode(
      bucket: _calculateBucket(publishedAt!),
      channel: channel.name,
      host: channel.host,
      title: title!,
      date: publishedAt!.toIso8601String(),
      color: seed.toARGB32(),
      image: channel.image,
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
