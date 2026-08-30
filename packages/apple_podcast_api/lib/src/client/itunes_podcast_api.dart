import 'dart:convert';

import 'package:apple_podcast_api/src/client/base_handler.dart';
import 'package:apple_podcast_api/src/models/api_failure.dart';
import 'package:apple_podcast_api/src/models/enums.dart';
import 'package:apple_podcast_api/src/models/itunes_podcast.dart';
import 'package:apple_podcast_api/src/models/podcast_author.dart';
import 'package:apple_podcast_api/src/models/podcast_episode.dart';
import 'package:apple_podcast_api/src/models/search_response.dart';
import 'package:apple_podcast_api/src/models/types.dart';
import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';

/// Podcast client built on top of the iTunes Search API.
/// https://performance-partners.apple.com/search-api
class ItunesPodcastApi {
  static const String baseUrl = 'https://itunes.apple.com';

  ItunesPodcastApi({String? customBaseUrl, Dio? httpClient})
    : _handler = BaseHandler(
        baseUrl: customBaseUrl ?? baseUrl,
        httpClient: httpClient,
      );

  final BaseHandler _handler;

  /// Searches the podcast store and returns every result shape
  /// (shows / authors / episodes), discriminated per entry.
  ///
  /// [attribute] narrows the search to a specific field of the store.
  /// [lang] switches the language of the returned metadata.
  /// [includeExplicit] set to `false` filters out explicit content.
  /// [version] selects the response key format (`1` or `2`, default `2`).
  ApiResult<SearchResponse> search(
    String term, {
    PodcastEntity? entity,
    PodcastAttribute? attribute,
    int? limit,
    LanguageCode? lang,
    String? country,
    int? version,
    bool includeExplicit = true,
  }) {
    return _search(
      term,
      entity: entity,
      attribute: attribute,
      limit: limit,
      lang: lang,
      country: country,
      version: version,
      includeExplicit: includeExplicit,
    ).parse(SearchResponse.fromJson).run();
  }

  /// Searches podcast shows.
  ApiResult<List<ItunesPodcast>> searchPodcasts(
    String term, {
    PodcastAttribute? attribute,
    int? limit,
    LanguageCode? lang,
    String? country,
    int? version,
    bool includeExplicit = true,
  }) {
    return _search(
      term,
      entity: PodcastEntity.podcast,
      attribute: attribute,
      limit: limit,
      lang: lang,
      country: country,
      version: version,
      includeExplicit: includeExplicit,
    ).parse((data) => SearchResponse.fromJson(data).podcasts).run();
  }

  /// Searches podcast authors (hosts).
  ApiResult<List<PodcastAuthor>> searchAuthors(
    String term, {
    PodcastAttribute? attribute,
    int? limit,
    LanguageCode? lang,
    String? country,
    int? version,
    bool includeExplicit = true,
  }) {
    return _search(
      term,
      entity: PodcastEntity.podcastAuthor,
      attribute: attribute,
      limit: limit,
      lang: lang,
      country: country,
      version: version,
      includeExplicit: includeExplicit,
    ).parse((data) => SearchResponse.fromJson(data).authors).run();
  }

  /// Searches individual podcast episodes.
  ApiResult<List<PodcastEpisode>> searchEpisodes(
    String term, {
    PodcastAttribute? attribute,
    int? limit,
    LanguageCode? lang,
    String? country,
    int? version,
    bool includeExplicit = true,
  }) {
    return _search(
      term,
      entity: PodcastEntity.podcastEpisode,
      attribute: attribute,
      limit: limit,
      lang: lang,
      country: country,
      version: version,
      includeExplicit: includeExplicit,
    ).parse((data) => SearchResponse.fromJson(data).episodes).run();
  }

  /// Looks up resources by iTunes ids and returns every result shape.
  ///
  /// Depending on the requested [entity] the results contain shows, authors
  /// or episodes; use the typed helpers ([lookupShows], [lookupEpisodes],
  /// [lookupAuthors]) when a single shape is expected.
  ApiResult<SearchResponse> lookup({
    required List<int> ids,
    PodcastEntity? entity,
    int? limit,
    String? country,
  }) {
    return _lookup(
      ids: ids,
      entity: entity,
      limit: limit,
      country: country,
    ).parse(SearchResponse.fromJson).run();
  }

  /// Looks up podcast shows by their collection [ids].
  ApiResult<List<ItunesPodcast>> lookupShows(List<int> ids, {String? country}) {
    return _lookup(
      ids: ids,
      entity: PodcastEntity.podcast,
      country: country,
    ).parse((data) => SearchResponse.fromJson(data).podcasts).run();
  }

  /// Looks up recent episodes of the show with collection id [collectionId].
  ///
  /// The response also contains the show itself, which is filtered out;
  /// only episodes are returned in reverse chronological order.
  ApiResult<List<PodcastEpisode>> lookupEpisodes(
    int collectionId, {
    int? limit,
    String? country,
  }) {
    return _lookup(
      ids: [collectionId],
      entity: PodcastEntity.podcastEpisode,
      limit: limit,
      country: country,
    ).parse((data) => SearchResponse.fromJson(data).episodes).run();
  }

  /// Looks up podcast authors by their artist [ids].
  ApiResult<List<PodcastAuthor>> lookupAuthors(
    List<int> ids, {
    String? country,
  }) {
    return _lookup(
      ids: ids,
      country: country,
    ).parse((data) => SearchResponse.fromJson(data).authors).run();
  }

  // Builds and executes a GET request against `/search`.
  HandlerTask<dynamic> _search(
    String term, {
    PodcastEntity? entity,
    PodcastAttribute? attribute,
    int? limit,
    LanguageCode? lang,
    String? country,
    int? version,
    bool includeExplicit = true,
  }) {
    return _handler.get('/search', {
      'term': term,
      // Always pin the media type so results stay within podcasts even when
      // no explicit entity is requested.
      'media': 'podcast',
      'entity': ?entity?.wireValue,
      'attribute': ?attribute?.wireValue,
      'limit': ?limit,
      'lang': ?lang?.wireValue,
      'country': ?country,
      'version': ?version,
      'explicit': includeExplicit ? 'Yes' : 'No',
    });
  }

  // Builds and executes a GET request against `/lookup`.
  HandlerTask<dynamic> _lookup({
    required List<int> ids,
    PodcastEntity? entity,
    int? limit,
    String? country,
  }) {
    assert(ids.isNotEmpty, 'ids must not be empty');
    return _handler.get('/lookup', {
      'id': ids.join(','),
      'entity': ?entity?.wireValue,
      'limit': ?limit,
      'country': ?country,
    });
  }

  void close() => _handler.close();
}

// Parses the raw response body into a strongly typed value.
extension _ResponseParsing on TaskEither<ApiFailure, Response<dynamic>> {
  TaskEither<ApiFailure, T> parse<T>(
    T Function(Map<String, dynamic> data) parser,
  ) {
    return flatMap((response) => _parseResponse(response, parser));
  }

  static TaskEither<ApiFailure, T> _parseResponse<T>(
    Response<dynamic> response,
    T Function(Map<String, dynamic> data) parser,
  ) {
    // The iTunes API replies with `text/javascript`, so Dio may leave the
    // body undecoded; accept both a decoded map and a raw JSON string.
    final dynamic data = response.data;
    if (data == null) {
      return TaskEither.left(
        const ParseFailure('Response data is empty', null),
      );
    }

    return TaskEither.tryCatch(() async {
      final json = data is Map<String, dynamic>
          ? data
          : jsonDecode(data as String) as Map<String, dynamic>;
      return parser(json);
    }, (error, stackTrace) => ParseFailure(error, stackTrace));
  }
}
