import 'package:apple_podcast_api/src/models/itunes_podcast.dart';
import 'package:apple_podcast_api/src/models/podcast_author.dart';
import 'package:apple_podcast_api/src/models/podcast_episode.dart';
import 'package:apple_podcast_api/src/models/search_result_item.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_response.freezed.dart';

/// Response body of the iTunes search / lookup endpoints.
@freezed
sealed class SearchResponse with _$SearchResponse {
  const SearchResponse._();

  const factory SearchResponse({
    @Default(0) int resultCount,
    @Default([]) List<SearchResultItem> results,
  }) = _SearchResponse;

  /// Parses a raw response body.
  ///
  /// The top-level structure is validated strictly, while individual entries
  /// that cannot be recognized are kept as [UnknownResult] instead of failing
  /// the whole response.
  factory SearchResponse.fromJson(Map<String, dynamic> json) {
    final rawResults = json['results'];
    if (rawResults != null && rawResults is! List<dynamic>) {
      throw FormatException(
        'Expected "results" to be a list but got ${rawResults.runtimeType}',
      );
    }

    return SearchResponse(
      resultCount: (json['resultCount'] as num?)?.toInt() ?? 0,
      results:
          (rawResults as List<dynamic>? ?? const [])
              .whereType<Map<String, dynamic>>()
              .map(SearchResultItem.fromJson)
              .toList(),
    );
  }

  /// Show results (`entity=podcast`).
  List<ItunesPodcast> get podcasts =>
      [for (final item in results) if (item is PodcastResult) item.podcast];

  /// Author results (`entity=podcastAuthor`).
  List<PodcastAuthor> get authors =>
      [for (final item in results) if (item is AuthorResult) item.author];

  /// Episode results (`entity=podcastEpisode`).
  List<PodcastEpisode> get episodes =>
      [for (final item in results) if (item is EpisodeResult) item.episode];
}
