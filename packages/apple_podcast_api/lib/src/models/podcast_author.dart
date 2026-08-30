import 'package:freezed_annotation/freezed_annotation.dart';

part 'podcast_author.freezed.dart';
part 'podcast_author.g.dart';

/// A podcast author (host) returned by the iTunes Search API
/// (`entity=podcastAuthor`, wrapperType=`artist`).
@freezed
sealed class PodcastAuthor with _$PodcastAuthor {
  const factory PodcastAuthor({
    String? wrapperType,
    String? artistType,
    int? artistId,
    String? artistName,
    String? artistLinkUrl,
    String? primaryGenreName,
    int? primaryGenreId,
    List<String>? genres,
    List<String>? genreIds,
  }) = _PodcastAuthor;

  factory PodcastAuthor.fromJson(Map<String, dynamic> json) =>
      _$PodcastAuthorFromJson(json);
}
