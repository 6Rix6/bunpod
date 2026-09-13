import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:bunpod/bunpod.dart';

extension RSSPodcastFeedMapper on RSSPodcastFeed {
  Future<PodcastFeed?> toPodcastFeed({
    required int id,
    required String url,
    required Map<String, int> episodeIds,
  }) async {
    if (imageUrl == null) return null;

    final seed = await ImageColorCache.of(imageUrl!);

    final channel = toChannel(id: id, seed: seed, feedUrl: url);
    if (channel == null) return null;

    final eps = episodes
        .map(
          (e) => e.toEpisode(
            id: episodeIds[e.guid],
            seed: seed,
            channel: channel,
          ),
        )
        .whereType<Episode>()
        .toList();

    return PodcastFeed(url: url, channel: channel, episodes: eps);
  }

  Channel? toChannel({
    required int id,
    required int seed,
    required String feedUrl,
  }) {
    if (title == null || ownerName == null || imageUrl == null) {
      return null;
    }

    return Channel(
      localId: id,
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

extension RSSFeedEpisodeMapper on RSSFeedEpisode {
  Episode? toEpisode({
    required int? id,
    required int seed,
    required Channel channel,
  }) {
    if (id == null ||
        guid == null ||
        title == null ||
        publishedAt == null ||
        audioUrl == null ||
        duration == null) {
      return null;
    }

    return Episode(
      localId: id,
      guid: guid!,
      bucket: calculateBucket(publishedAt!),
      channel: channel.name,
      host: channel.host,
      title: title!,
      date: publishedAt!.toIso8601String(),
      color: seed,
      image: channel.image,
      feedurl: channel.feedUrl,
      audioUrl: audioUrl!,
      total: duration!,
    );
  }
}

Bucket calculateBucket(DateTime date) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final targetDate = DateTime(date.year, date.month, date.day);

  final differenceInDays = today.difference(targetDate).inDays;

  if (differenceInDays == 0) return Bucket.today;
  if (differenceInDays == 1) return Bucket.yesterday;
  if (differenceInDays > 1 && differenceInDays <= 7) return Bucket.thisWeek;
  if (date.year == now.year && date.month == now.month) return Bucket.thisMonth;
  return Bucket.earlier;
}
