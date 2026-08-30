// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'podcast_author.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PodcastAuthor _$PodcastAuthorFromJson(Map<String, dynamic> json) =>
    _PodcastAuthor(
      wrapperType: json['wrapperType'] as String?,
      artistType: json['artistType'] as String?,
      artistId: (json['artistId'] as num?)?.toInt(),
      artistName: json['artistName'] as String?,
      artistLinkUrl: json['artistLinkUrl'] as String?,
      primaryGenreName: json['primaryGenreName'] as String?,
      primaryGenreId: (json['primaryGenreId'] as num?)?.toInt(),
      genres: (json['genres'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      genreIds: (json['genreIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$PodcastAuthorToJson(_PodcastAuthor instance) =>
    <String, dynamic>{
      'wrapperType': instance.wrapperType,
      'artistType': instance.artistType,
      'artistId': instance.artistId,
      'artistName': instance.artistName,
      'artistLinkUrl': instance.artistLinkUrl,
      'primaryGenreName': instance.primaryGenreName,
      'primaryGenreId': instance.primaryGenreId,
      'genres': instance.genres,
      'genreIds': instance.genreIds,
    };
