import 'dart:convert';
import 'dart:typed_data';

import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

const _showJson = {
  'wrapperType': 'track',
  'kind': 'podcast',
  'collectionId': 12345,
  'trackId': 12345,
  'artistName': 'Example Host',
  'collectionName': 'Example Podcast',
  'trackName': 'Example Podcast',
  'feedUrl': 'https://example.com/feed.rss',
  'artworkUrl600': 'https://example.com/art.jpg',
  'releaseDate': '2026-01-01T00:00:00Z',
  'collectionPrice': 0,
  'trackCount': 42,
  'country': 'JP',
  'currency': 'JPY',
  'primaryGenreName': 'Technology',
  'genreIds': ['1512', '1301'],
  'genres': ['Tech', 'News'],
};

const _minimalShowJson = {
  'wrapperType': 'track',
  'kind': 'podcast',
  'collectionId': 67890,
  'collectionName': 'Minimal Podcast',
};

const _episodeJson = {
  'wrapperType': 'podcastEpisode',
  'kind': 'podcast-episode',
  'collectionId': 12345,
  'trackId': 99999,
  'artistName': 'Example Host',
  'collectionName': 'Example Podcast',
  'trackName': 'Episode 1',
  'feedUrl': 'https://example.com/feed.rss',
  'artworkUrl160': 'https://example.com/art160.jpg',
  'releaseDate': '2026-02-01T00:00:00Z',
  'trackTimeMillis': 3600000,
  'trackNumber': 1,
  'description': 'Full episode description',
  'shortDescription': 'Short description',
  'episodeUrl': 'https://example.com/ep1.mp3',
  'episodeFileExtension': 'mp3',
  'episodeContentType': 'audio/mpeg',
};

const _authorJson = {
  'wrapperType': 'artist',
  'artistType': 'Show',
  'artistId': 55555,
  'artistName': 'Example Host',
  'artistLinkUrl': 'https://podcasts.apple.com/artist/example-host',
  'primaryGenreName': 'Technology',
};

const _feedXml = '''
<?xml version="1.0" encoding="UTF-8"?>
<rss xmlns:itunes="http://www.itunes.com/dtds/podcast-1.0.dtd"
     xmlns:content="http://purl.org/rss/1.0/modules/content/"
     xmlns:podcast="https://podcastindex.org/namespace/1.0"
     version="2.0">
  <channel>
    <title><![CDATA[Example Show & More]]></title>
    <link>https://example.com</link>
    <description>A show about things</description>
    <language>ja-jp</language>
    <copyright>(c) 2026 Example</copyright>
    <generator>TestGenerator</generator>
    <lastBuildDate>Tue, 25 Aug 2026 09:00:00 +0900</lastBuildDate>
    <itunes:author>Example Host</itunes:author>
    <itunes:owner>
      <itunes:name>Owner Name</itunes:name>
      <itunes:email>owner@example.com</itunes:email>
    </itunes:owner>
    <itunes:image href="https://example.com/cover.jpg"/>
    <itunes:explicit>true</itunes:explicit>
    <itunes:type>episodic</itunes:type>
    <itunes:category text="Technology"/>
    <category>Tech</category>
    <category>Tech</category>
    <podcast:guid>a1b2c3d4</podcast:guid>
    <podcast:locked owner="owner@example.com">yes</podcast:locked>
    <podcast:funding url="https://example.com/donate">Support us</podcast:funding>
    <podcast:person href="https://example.com/host" role="host">Host Person</podcast:person>
    <item>
      <guid>ep-1-guid</guid>
      <title><![CDATA[Episode 1]]></title>
      <description>First episode with &lt;b&gt;tags&lt;/b&gt;</description>
      <content:encoded><![CDATA[<p>Full HTML body</p>]]></content:encoded>
      <link>https://example.com/ep1</link>
      <pubDate>Sat, 01 Aug 2026 10:00:00 GMT</pubDate>
      <enclosure url="https://cdn.example.com/ep1.mp3" length="12345678" type="audio/mpeg"/>
      <itunes:author>Guest Host</itunes:author>
      <itunes:duration>1:02:03</itunes:duration>
      <itunes:episode>12</itunes:episode>
      <itunes:season>3</itunes:season>
      <itunes:episodeType>full</itunes:episodeType>
      <itunes:image href="https://example.com/ep1.jpg"/>
      <podcast:chapters url="https://example.com/ep1.chapters.json" type="application/json+chapters"/>
      <podcast:transcript url="https://example.com/ep1.vtt" type="text/vtt" language="ja"/>
      <podcast:transcript url="https://example.com/ep1.srt" type="application/srt"/>
      <podcast:person role="host" group="people" img="https://example.com/host.jpg">Host Person</podcast:person>
    </item>
    <item>
      <title>Bare Episode</title>
      <pubDate>8/1/2026</pubDate>
      <enclosure url="https://cdn.example.com/bare.mp3" length="42" type="audio/mp3"/>
      <itunes:duration>45:06</itunes:duration>
    </item>
  </channel>
</rss>
''';

// Serves canned payloads (or throws) instead of hitting the network.
class _FakeAdapter implements HttpClientAdapter {
  _FakeAdapter({this.payload, this.rawBody, this.error, this.statusCode = 200});

  final Object? payload;

  /// Served as-is instead of [payload] (e.g. for RSS/XML bodies).
  final String? rawBody;
  final DioException? error;
  final int statusCode;

  /// The options of the most recent request, for asserting query parameters.
  RequestOptions? lastOptions;

  @override
  void close({bool force = false}) {}

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<Uint8List>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastOptions = options;
    if (error != null) throw error!;
    // Deliberately use `text/javascript`: the iTunes API serves this content
    // type, which prevents Dio from decoding the body automatically.
    return ResponseBody.fromString(
      rawBody ?? jsonEncode(payload),
      statusCode,
      headers: {
        Headers.contentTypeHeader: [
          rawBody != null
              ? 'application/rss+xml'
              : 'text/javascript; charset=utf-8',
        ],
      },
    );
  }
}

ItunesPodcastApi _itunesPodcastApiWith(_FakeAdapter adapter) {
  final dio = Dio(BaseOptions(baseUrl: ItunesPodcastApi.baseUrl));
  dio.httpClientAdapter = adapter;
  return ItunesPodcastApi(httpClient: dio);
}

RSSFeedClient _rssFeedClientWith(_FakeAdapter adapter) {
  final dio = Dio();
  dio.httpClientAdapter = adapter;
  return RSSFeedClient(httpClient: dio);
}

void main() {
  group('searchPodcasts', () {
    test('parses a successful response and sends expected params', () async {
      final adapter = _FakeAdapter(
        payload: {
          'resultCount': 2,
          'results': [_showJson, _minimalShowJson],
        },
      );
      final api = _itunesPodcastApiWith(adapter);

      final result = await api.searchPodcasts(
        'example',
        limit: 25,
        country: 'jp',
        lang: LanguageCode.japanese,
        attribute: PodcastAttribute.titleTerm,
        includeExplicit: false,
      );

      expect(adapter.lastOptions!.path, '/search');
      expect(adapter.lastOptions!.queryParameters, {
        'term': 'example',
        'media': 'podcast',
        'entity': 'podcast',
        'attribute': 'titleTerm',
        'limit': 25,
        'lang': 'ja_jp',
        'country': 'jp',
        'explicit': 'No',
      });

      final response = result.fold(
        (f) => fail('expected success: $f'),
        (r) => r,
      );
      expect(response.data, isNotNull);

      final shows = response.data!;

      expect(shows, hasLength(2));

      final full = shows[0];
      expect(full.collectionId, 12345);
      expect(full.artistName, 'Example Host');
      expect(full.feedUrl, 'https://example.com/feed.rss');
      expect(full.releaseDate, DateTime.utc(2026, 1, 1));
      expect(full.collectionPrice, 0.0);
      expect(full.trackCount, 42);
      expect(full.genres, ['Tech', 'News']);

      final minimal = shows[1];
      expect(minimal.collectionName, 'Minimal Podcast');
      expect(minimal.feedUrl, isNull);
      expect(minimal.genres, isNull);
    });

    test('omits optional params when not requested', () async {
      final adapter = _FakeAdapter(
        payload: const {'resultCount': 0, 'results': []},
      );
      final api = _itunesPodcastApiWith(adapter);

      await api.searchPodcasts('example');

      expect(adapter.lastOptions!.queryParameters, {
        'term': 'example',
        'media': 'podcast',
        'entity': 'podcast',
        'explicit': 'Yes',
      });
    });
  });

  group('searchAuthors', () {
    test('parses author results', () async {
      final api = _itunesPodcastApiWith(
        _FakeAdapter(
          payload: {
            'resultCount': 1,
            'results': [_authorJson],
          },
        ),
      );

      final result = await api.searchAuthors('example host');

      final response = result.fold(
        (f) => fail('expected success: $f'),
        (r) => r,
      );
      expect(response, isNotNull);

      final authors = response.data!;
      expect(authors, hasLength(1));
      expect(authors.first.artistId, 55555);
      expect(authors.first.artistType, 'Show');
      expect(
        authors.first.artistLinkUrl,
        'https://podcasts.apple.com/artist/example-host',
      );
    });
  });

  group('searchEpisodes', () {
    test('parses episode results', () async {
      final api = _itunesPodcastApiWith(
        _FakeAdapter(
          payload: {
            'resultCount': 1,
            'results': [_episodeJson],
          },
        ),
      );

      final result = await api.searchEpisodes('episode');

      final response = result.fold(
        (f) => fail('expected success: $f'),
        (r) => r,
      );
      expect(response.data, isNotNull);

      final episodes = response.data!;
      expect(episodes, hasLength(1));

      final episode = episodes.first;
      expect(episode.trackId, 99999);
      expect(episode.episodeUrl, 'https://example.com/ep1.mp3');
      expect(episode.episodeContentType, 'audio/mpeg');
      expect(episode.description, 'Full episode description');
      expect(episode.shortDescription, 'Short description');
      expect(episode.trackNumber, 1);
      expect(episode.trackTimeMillis, 3600000);
      expect(episode.releaseDate, DateTime.utc(2026, 2, 1));
    });

    test('sends entity=podcastEpisode', () async {
      final adapter = _FakeAdapter(
        payload: const {'resultCount': 0, 'results': []},
      );
      final api = _itunesPodcastApiWith(adapter);

      await api.searchEpisodes('episode');

      expect(adapter.lastOptions!.queryParameters['entity'], 'podcastEpisode');
    });
  });

  group('generic search', () {
    test('discriminates mixed result shapes', () async {
      final api = _itunesPodcastApiWith(
        _FakeAdapter(
          payload: {
            'resultCount': 4,
            'results': [
              _showJson,
              _episodeJson,
              _authorJson,
              {'something': 'else'},
            ],
          },
        ),
      );

      final result = await api.search('example');

      final response = result.fold(
        (f) => fail('expected success: $f'),
        (r) => r,
      );

      expect(response.data, isNotNull);

      final searchRes = response.data!;

      expect(searchRes.resultCount, 4);
      expect(searchRes.podcasts, hasLength(1));
      expect(searchRes.podcasts.first.collectionId, 12345);
      expect(searchRes.episodes, hasLength(1));
      expect(searchRes.authors, hasLength(1));
      expect(searchRes.results.last, isA<UnknownResult>());
    });
  });

  group('lookup', () {
    test('lookupEpisodes filters out the show entry', () async {
      final adapter = _FakeAdapter(
        payload: {
          'resultCount': 3,
          'results': [_showJson, _episodeJson, _authorJson],
        },
      );
      final api = _itunesPodcastApiWith(adapter);

      final result = await api.lookupEpisodes(12345, limit: 10, country: 'us');

      expect(adapter.lastOptions!.path, '/lookup');
      expect(adapter.lastOptions!.queryParameters, {
        'id': '12345',
        'entity': 'podcastEpisode',
        'limit': 10,
        'country': 'us',
      });

      final response = result.fold(
        (f) => fail('expected success: $f'),
        (r) => r,
      );
      expect(response.data, isNotNull);

      final episodes = response.data!;

      expect(episodes, hasLength(1));
      expect(episodes.first.trackName, 'Episode 1');
    });

    test('lookupShows joins ids and requests podcasts', () async {
      final adapter = _FakeAdapter(
        payload: const {'resultCount': 0, 'results': []},
      );
      final api = _itunesPodcastApiWith(adapter);

      await api.lookupShows([12345, 67890]);

      expect(adapter.lastOptions!.queryParameters['id'], '12345,67890');
      expect(adapter.lastOptions!.queryParameters['entity'], 'podcast');
    });

    test('lookupAuthors omits entity', () async {
      final adapter = _FakeAdapter(
        payload: {
          'resultCount': 1,
          'results': [_authorJson],
        },
      );
      final api = _itunesPodcastApiWith(adapter);

      final result = await api.lookupAuthors([55555]);

      expect(
        adapter.lastOptions!.queryParameters.containsKey('entity'),
        isFalse,
      );
      final response = result.fold(
        (f) => fail('expected success: $f'),
        (r) => r,
      );

      expect(response.data, isNotNull);

      final authors = response.data!;

      expect(authors.first.artistId, 55555);
    });

    test('generic lookup keeps every shape', () async {
      final api = _itunesPodcastApiWith(
        _FakeAdapter(
          payload: {
            'resultCount': 2,
            'results': [_showJson, _authorJson],
          },
        ),
      );

      final result = await api.lookup(
        ids: [12345],
        entity: PodcastEntity.podcast,
      );

      final response = result.fold(
        (f) => fail('expected success: $f'),
        (r) => r,
      );

      expect(response.data, isNotNull);

      final searchRes = response.data!;

      expect(searchRes.results.map((r) => r.runtimeType), [
        PodcastResult,
        AuthorResult,
      ]);
    });
  });

  group('fetchFeed', () {
    test('parses a full feed with iTunes and podcast tags', () async {
      final adapter = _FakeAdapter(rawBody: _feedXml);
      final api = _rssFeedClientWith(adapter);

      final result = await api.fetchFeed(
        Uri.parse('https://example.com/feed.xml'),
      );

      expect(
        adapter.lastOptions!.uri,
        Uri.parse('https://example.com/feed.xml'),
      );
      final response = result.fold(
        (f) => fail('expected success: $f'),
        (r) => r,
      );

      expect(response.data, isNotNull);

      final feed = response.data!;

      expect(feed.url, Uri.parse('https://example.com/feed.xml'));
      expect(feed.title, 'Example Show & More');
      expect(feed.link, 'https://example.com');
      expect(feed.description, 'A show about things');
      expect(feed.language, 'ja-jp');
      expect(feed.author, 'Example Host');
      expect(feed.ownerName, 'Owner Name');
      expect(feed.ownerEmail, 'owner@example.com');
      expect(feed.imageUrl, 'https://example.com/cover.jpg');
      expect(feed.explicit, isTrue);
      // iTunes + plain categories merged, duplicates removed.
      expect(feed.categories, ['Technology', 'Tech']);
      expect(feed.lastBuildDate, DateTime.utc(2026, 8, 25));
      expect(feed.guid, 'a1b2c3d4');
      expect(feed.locked, isTrue);
      expect(feed.lockedOwner, 'owner@example.com');
      expect(feed.funding.single.url, Uri.parse('https://example.com/donate'));
      expect(feed.funding.single.description, 'Support us');
      expect(feed.persons.single.name, 'Host Person');

      expect(feed.episodes, hasLength(2));

      final first = feed.episodes[0];
      expect(first.guid, 'ep-1-guid');
      expect(first.title, 'Episode 1');
      expect(first.description, 'First episode with <b>tags</b>');
      expect(first.htmlDescription, '<p>Full HTML body</p>');
      expect(first.publishedAt, DateTime.utc(2026, 8, 1, 10));
      expect(first.audioUrl, 'https://cdn.example.com/ep1.mp3');
      expect(first.audioSizeBytes, 12345678);
      expect(first.audioType, 'audio/mpeg');
      expect(first.duration, const Duration(hours: 1, minutes: 2, seconds: 3));
      expect(first.episodeNumber, 12);
      expect(first.seasonNumber, 3);
      expect(first.episodeType, RSSFeedEpisodeType.full);
      expect(first.author, 'Guest Host');
      expect(first.imageUrl, 'https://example.com/ep1.jpg');
      expect(
        first.chaptersUrl,
        Uri.parse('https://example.com/ep1.chapters.json'),
      );
      expect(first.chaptersType, 'application/json+chapters');
      expect(first.transcripts, hasLength(2));
      expect(first.transcripts[0].type, 'text/vtt');
      expect(first.transcripts[0].language, 'ja');
      expect(first.persons.single.role, 'host');
      expect(first.persons.single.group, 'people');
      expect(
        first.persons.single.imageUrl,
        Uri.parse('https://example.com/host.jpg'),
      );

      // Minimal item: missing tags stay null; duration still parsed.
      final bare = feed.episodes[1];
      expect(bare.title, 'Bare Episode');
      expect(bare.duration, const Duration(minutes: 45, seconds: 6));
      expect(bare.publishedAt, isNull);
      expect(bare.episodeType, RSSFeedEpisodeType.full); // spec default
      expect(bare.htmlDescription, isNull);
      expect(bare.transcripts, isEmpty);
    });

    test('maps invalid XML to ParseFailure', () async {
      final api = _rssFeedClientWith(
        _FakeAdapter(rawBody: '<rss><channel><unclosed'),
      );

      final result = await api.fetchFeed(Uri.parse('https://example.com/feed'));

      expect(result.isLeft(), isTrue);
      expect(
        result.fold((f) => f, (r) => fail('expected failure')),
        isA<ParseFailure>(),
      );
    });

    test('maps an HTTP error to HttpFailure', () async {
      final api = _rssFeedClientWith(
        _FakeAdapter(rawBody: 'gone', statusCode: 404),
      );

      final result = await api.fetchFeed(Uri.parse('https://example.com/feed'));

      expect(result.isLeft(), isTrue);
      expect(
        (result.fold(
          (f) => f,
          (r) => fail('expected failure'),
        ) as HttpFailure).statusCode,
        404,
      );
    });

    test('fetchFeedFor fails when the show has no feed URL', () async {
      final api = _rssFeedClientWith(_FakeAdapter(rawBody: _feedXml));

      final result = await api.fetchFeedFor(
        const ItunesPodcast(collectionName: 'no url show'),
      );

      expect(result.isLeft(), isTrue);
      expect(
        result.fold((f) => f, (r) => fail('expected failure')),
        isA<ParseFailure>(),
      );
    });
  });

  group('failures', () {
    test('maps an HTTP error status to HttpFailure', () async {
      final api = _itunesPodcastApiWith(
        _FakeAdapter(payload: {'error': 'not found'}, statusCode: 404),
      );

      final result = await api.searchPodcasts('example');

      expect(result.isLeft(), isTrue);
      final failure = result.fold((f) => f, (r) => fail('expected failure'));
      expect((failure as HttpFailure).statusCode, 404);
    });

    test('maps a cancelled request to CancelledFailure', () async {
      final api = _itunesPodcastApiWith(
        _FakeAdapter(
          error: DioException(
            requestOptions: RequestOptions(path: '/search'),
            type: DioExceptionType.cancel,
          ),
        ),
      );

      final result = await api.searchPodcasts('example');

      expect(result.isLeft(), isTrue);
      expect(
        result.fold((f) => f, (r) => fail('expected failure')),
        isA<CancelledFailure>(),
      );
    });

    test('maps a malformed body to ParseFailure', () async {
      final api = _itunesPodcastApiWith(
        _FakeAdapter(payload: {'results': 'not-a-list'}),
      );

      final result = await api.searchPodcasts('example');

      expect(result.isLeft(), isTrue);
      expect(
        result.fold((f) => f, (r) => fail('expected failure')),
        isA<ParseFailure>(),
      );
    });

    test('supports exhaustive pattern matching', () {
      const failures = <ApiFailure>[
        NetworkFailure('boom'),
        CancelledFailure(),
        HttpFailure(statusCode: 500, message: 'server error'),
        ParseFailure('bad json', null),
        UnknownFailure('oops', StackTrace.empty),
      ];

      final kinds = failures
          .map(
            (f) => switch (f) {
              NetworkFailure() => 'network',
              CancelledFailure() => 'cancelled',
              HttpFailure(:final statusCode) => 'http-$statusCode',
              ParseFailure() => 'parse',
              UnknownFailure() => 'unknown',
            },
          )
          .toList();

      expect(kinds, ['network', 'cancelled', 'http-500', 'parse', 'unknown']);
    });
  });
}
