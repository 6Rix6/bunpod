import 'package:freezed_annotation/freezed_annotation.dart';

part 'podcast_episode.freezed.dart';
part 'podcast_episode.g.dart';

/// A single podcast episode returned by the iTunes Search API
/// (`entity=podcastEpisode`, kind=`podcast-episode`).
///
/// Every field is nullable because the API omits keys depending on the result.
@freezed
sealed class PodcastEpisode with _$PodcastEpisode {
  const factory PodcastEpisode({
    String? wrapperType,
    String? kind,
    int? artistId,
    int? collectionId,
    int? trackId,
    String? artistName,
    String? collectionName,
    String? trackName,
    String? collectionCensoredName,
    String? trackCensoredName,
    String? artistViewUrl,
    String? collectionViewUrl,
    String? feedUrl,
    String? trackViewUrl,
    String? artworkUrl30,
    String? artworkUrl60,
    String? artworkUrl100,
    String? artworkUrl160,
    String? artworkUrl600,
    double? collectionPrice,
    double? trackPrice,
    DateTime? releaseDate,
    String? collectionExplicitness,
    String? trackExplicitness,
    int? trackCount,
    int? trackNumber,
    int? trackTimeMillis,
    String? country,
    String? currency,
    String? primaryGenreName,
    String? contentAdvisoryRating,
    String? description,
    String? shortDescription,
    String? episodeUrl,
    String? episodeFileExtension,
    String? episodeContentType,
    List<String>? genreIds,
    List<String>? genres,
    List<int>? artistIds,
    bool? isStreamable,
  }) = _PodcastEpisode;

  factory PodcastEpisode.fromJson(Map<String, dynamic> json) =>
      _$PodcastEpisodeFromJson(json);
}
