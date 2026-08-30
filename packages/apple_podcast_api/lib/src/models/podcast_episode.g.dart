// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PodcastEpisode _$PodcastEpisodeFromJson(Map<String, dynamic> json) =>
    _PodcastEpisode(
      wrapperType: json['wrapperType'] as String?,
      kind: json['kind'] as String?,
      artistId: (json['artistId'] as num?)?.toInt(),
      collectionId: (json['collectionId'] as num?)?.toInt(),
      trackId: (json['trackId'] as num?)?.toInt(),
      artistName: json['artistName'] as String?,
      collectionName: json['collectionName'] as String?,
      trackName: json['trackName'] as String?,
      collectionCensoredName: json['collectionCensoredName'] as String?,
      trackCensoredName: json['trackCensoredName'] as String?,
      artistViewUrl: json['artistViewUrl'] as String?,
      collectionViewUrl: json['collectionViewUrl'] as String?,
      feedUrl: json['feedUrl'] as String?,
      trackViewUrl: json['trackViewUrl'] as String?,
      artworkUrl30: json['artworkUrl30'] as String?,
      artworkUrl60: json['artworkUrl60'] as String?,
      artworkUrl100: json['artworkUrl100'] as String?,
      artworkUrl160: json['artworkUrl160'] as String?,
      artworkUrl600: json['artworkUrl600'] as String?,
      collectionPrice: (json['collectionPrice'] as num?)?.toDouble(),
      trackPrice: (json['trackPrice'] as num?)?.toDouble(),
      releaseDate: json['releaseDate'] == null
          ? null
          : DateTime.parse(json['releaseDate'] as String),
      collectionExplicitness: json['collectionExplicitness'] as String?,
      trackExplicitness: json['trackExplicitness'] as String?,
      trackCount: (json['trackCount'] as num?)?.toInt(),
      trackNumber: (json['trackNumber'] as num?)?.toInt(),
      trackTimeMillis: (json['trackTimeMillis'] as num?)?.toInt(),
      country: json['country'] as String?,
      currency: json['currency'] as String?,
      primaryGenreName: json['primaryGenreName'] as String?,
      contentAdvisoryRating: json['contentAdvisoryRating'] as String?,
      description: json['description'] as String?,
      shortDescription: json['shortDescription'] as String?,
      episodeUrl: json['episodeUrl'] as String?,
      episodeFileExtension: json['episodeFileExtension'] as String?,
      episodeContentType: json['episodeContentType'] as String?,
      genreIds: (json['genreIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      artistIds: (json['artistIds'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      isStreamable: json['isStreamable'] as bool?,
    );

Map<String, dynamic> _$PodcastEpisodeToJson(_PodcastEpisode instance) =>
    <String, dynamic>{
      'wrapperType': instance.wrapperType,
      'kind': instance.kind,
      'artistId': instance.artistId,
      'collectionId': instance.collectionId,
      'trackId': instance.trackId,
      'artistName': instance.artistName,
      'collectionName': instance.collectionName,
      'trackName': instance.trackName,
      'collectionCensoredName': instance.collectionCensoredName,
      'trackCensoredName': instance.trackCensoredName,
      'artistViewUrl': instance.artistViewUrl,
      'collectionViewUrl': instance.collectionViewUrl,
      'feedUrl': instance.feedUrl,
      'trackViewUrl': instance.trackViewUrl,
      'artworkUrl30': instance.artworkUrl30,
      'artworkUrl60': instance.artworkUrl60,
      'artworkUrl100': instance.artworkUrl100,
      'artworkUrl160': instance.artworkUrl160,
      'artworkUrl600': instance.artworkUrl600,
      'collectionPrice': instance.collectionPrice,
      'trackPrice': instance.trackPrice,
      'releaseDate': instance.releaseDate?.toIso8601String(),
      'collectionExplicitness': instance.collectionExplicitness,
      'trackExplicitness': instance.trackExplicitness,
      'trackCount': instance.trackCount,
      'trackNumber': instance.trackNumber,
      'trackTimeMillis': instance.trackTimeMillis,
      'country': instance.country,
      'currency': instance.currency,
      'primaryGenreName': instance.primaryGenreName,
      'contentAdvisoryRating': instance.contentAdvisoryRating,
      'description': instance.description,
      'shortDescription': instance.shortDescription,
      'episodeUrl': instance.episodeUrl,
      'episodeFileExtension': instance.episodeFileExtension,
      'episodeContentType': instance.episodeContentType,
      'genreIds': instance.genreIds,
      'genres': instance.genres,
      'artistIds': instance.artistIds,
      'isStreamable': instance.isStreamable,
    };
