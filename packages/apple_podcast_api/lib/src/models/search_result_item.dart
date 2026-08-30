import 'package:apple_podcast_api/src/models/itunes_podcast.dart';
import 'package:apple_podcast_api/src/models/podcast_author.dart';
import 'package:apple_podcast_api/src/models/podcast_episode.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result_item.freezed.dart';

/// A single entry of an iTunes search / lookup response.
///
/// The API mixes result shapes (show, author, episode) in one `results` array,
/// so each raw JSON object is discriminated by its `wrapperType` / `kind`.
@freezed
sealed class SearchResultItem with _$SearchResultItem {
  const factory SearchResultItem.podcast(ItunesPodcast podcast) = PodcastResult;

  const factory SearchResultItem.author(PodcastAuthor author) = AuthorResult;

  const factory SearchResultItem.episode(PodcastEpisode episode) =
      EpisodeResult;

  // Keeps unrecognized payloads accessible instead of failing the whole
  // response.
  const factory SearchResultItem.unknown(Map<String, dynamic> raw) =
      UnknownResult;

  /// Discriminates a raw JSON object into the matching result type.
  factory SearchResultItem.fromJson(Map<String, dynamic> json) {
    final wrapperType = json['wrapperType'] as String?;
    final kind = json['kind'] as String?;

    if (wrapperType == 'artist') {
      return SearchResultItem.author(PodcastAuthor.fromJson(json));
    }
    if (wrapperType == 'podcastEpisode' || kind == 'podcast-episode') {
      return SearchResultItem.episode(PodcastEpisode.fromJson(json));
    }
    if (wrapperType == 'track' && kind == 'podcast') {
      return SearchResultItem.podcast(ItunesPodcast.fromJson(json));
    }
    return SearchResultItem.unknown(json);
  }
}
