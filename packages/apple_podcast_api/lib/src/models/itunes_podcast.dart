import 'package:freezed_annotation/freezed_annotation.dart';

part 'itunes_podcast.freezed.dart';
part 'itunes_podcast.g.dart';

/// A podcast entry returned by the iTunes Search API (`entity=podcast`).
///
/// Every field is nullable because the API omits keys depending on the result.
@freezed
sealed class ItunesPodcast with _$ItunesPodcast {
  const factory ItunesPodcast({
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
    String? artworkUrl600,
    double? collectionPrice,
    double? trackPrice,
    double? trackRentalPrice,
    double? collectionHdPrice,
    double? trackHdPrice,
    double? hdRentalPrice,
    DateTime? releaseDate,
    String? collectionExplicitness,
    String? trackExplicitness,
    int? trackCount,
    int? trackTimeMillis,
    String? country,
    String? currency,
    String? primaryGenreName,
    String? contentAdvisoryRating,
    String? copyright,
    List<String>? genreIds,
    List<String>? genres,
    List<int>? artistIds,
    bool? isStreamable,
  }) = _ItunesPodcast;

  factory ItunesPodcast.fromJson(Map<String, dynamic> json) =>
      _$ItunesPodcastFromJson(json);
}
