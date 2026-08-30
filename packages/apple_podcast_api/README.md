# apple_podcast_api

An unofficial Dart/Flutter client for the **Apple Podcasts catalog**, built on
top of the [iTunes Search API](https://performance-partners.apple.com/search-api).

Results are returned as typed model classes wrapped in an `Either<ApiFailure, T>`
([fpdart](https://pub.dev/packages/fpdart)), so errors are part of the return
type and can be handled exhaustively with pattern matching.

## Features

- **Search podcast shows** (`entity=podcast`)
- **Search podcast authors/hosts** (`entity=podcastAuthor`)
- **Search individual episodes** (`entity=podcastEpisode`)
- **Lookup by iTunes ID**: fetch shows, authors, or the latest episodes of a show
- **RSS feed parsing**: fetch and parse any podcast `feedUrl`, including
  `itunes:*` tags and key Podcasting 2.0 (`podcast:*`) tags
  (transcripts, chapters, funding, locked, guid, persons)
- All documented query parameters are supported: `term`, `attribute`, `limit`,
  `country`, `lang`, `version`, `explicit`
- Typed models: `Podcast`, `PodcastAuthor`, `PodcastEpisode`
- Mixed responses are discriminated per entry via `SearchResultItem`
- Functional error handling with a sealed `ApiFailure` hierarchy
- Automatic retries with exponential backoff on transient network errors
  (timeouts / connection errors)
- Injectable `Dio` instance and base URL for testing or custom HTTP setups

## Getting started

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  apple_podcast_api:
    git:
      url: <repository url>
```

Then import it:

```dart
import 'package:apple_podcast_api/apple_podcast_api.dart';
```

No setup is required; create a client and start querying:

```dart
final api = ItunesPodcastApi();
```

## Usage

### Search shows

```dart
final result = await api.searchPodcasts(
  'flutter', // search term
  limit: 25, // max results (1-200)
  country: 'jp', // ISO 3166-1 alpha-2 store front
  attribute: PodcastAttribute.titleTerm, // narrow search to one field
);

result.fold(
  (failure) => print('Search failed: $failure'),
  (shows) {
    for (final show in shows) {
      print('${show.collectionName} — ${show.feedUrl}');
    }
  },
);
```

### Search authors and episodes

```dart
// Authors (hosts). Results have wrapperType "artist".
final authors = await api.searchAuthors('example host');
authors.fold(
  (failure) => print(failure),
  (list) => print(list.map((a) => a.artistName)),
);

// Individual episodes.
final episodes = await api.searchEpisodes('dart');
episodes.fold(
  (failure) => print(failure),
  (list) => print(list.map((e) => e.episodeUrl)),
);
```

Available attributes (`PodcastAttribute`): `titleTerm`, `languageTerm`,
`authorTerm`, `genreIndex`, `artistTerm`, `ratingIndex`, `keywordsTerm`,
`descriptionTerm`.

### Look up by ID

```dart
// Shows by collection id.
await api.lookupShows([123456]);

// The 10 most recent episodes of a show (the show entry itself is filtered out).
await api.lookupEpisodes(123456, limit: 10);

// Authors by artist id.
await api.lookupAuthors([987654]);
```

### Mixed results

Use the generic methods when a response may contain several result shapes
(e.g. a show *and* its author). Every entry is discriminated into a
`SearchResultItem` subtype:

```dart
final result = await api.search('example');

result.fold(
  (failure) => print(failure),
  (response) => switch (response.results.first) {
    PodcastResult(:final podcast) => print('show: ${podcast.trackName}'),
    AuthorResult(:final author) => print('author: ${author.artistName}'),
    EpisodeResult(:final episode) => print('episode: ${episode.trackName}'),
    UnknownResult(:final raw) => print('unrecognized: $raw'),
  },
);
```

`SearchResponse` also exposes convenience getters that filter each shape:
`.podcasts`, `.authors`, `.episodes`.

### Fetch and parse an RSS feed

Every show returned by the API carries a `feedUrl`. The client downloads and
parses the feed (RSS 2.0 + `itunes:` + `podcast:` namespaces) into typed
models:

```dart
final result = await api.searchPodcasts('example');

final shows = result.fold((f) => fail('$f'), (s) => s);
final feed = await api.fetchFeedFor(shows.first);

feed.fold(
  (failure) => print(failure),
  (podcastFeed) {
    print(podcastFeed.author);          // itunes:author
    print(podcastFeed.explicit);        // itunes:explicit
    print(podcastFeed.locked);          // podcast:locked
    for (final episode in podcastFeed.episodes) {
      print(episode.title);
      print(episode.duration);          // Duration, from itunes:duration
      print(episode.audioUrl);          // enclosure
      print(episode.publishedAt);
      print(episode.transcripts);       // podcast:transcript references
    }
  },
);

// Or fetch directly by URL:
await api.fetchFeed(Uri.parse('https://example.com/feed.xml'));
```

Parsing is tolerant: missing tags stay `null`, unparseable dates/durations are
skipped, and only structurally broken XML produces a `ParseFailure`.
Supported Podcasting 2.0 tags: `podcast:guid`, `podcast:locked`,
`podcast:funding`, `podcast:person`, `podcast:transcript`,
`podcast:chapters`.

### Error handling

Every method returns `Future<Either<ApiFailure, T>>`. `ApiFailure` is a sealed
class, so `switch` statements can be checked for exhaustiveness:

```dart
final result = await api.searchPodcasts('news');

result.fold(
  (failure) => switch (failure) {
    NetworkFailure(:final message) => print('offline? $message'),
    HttpFailure(:final statusCode) => print('HTTP $statusCode'),
    CancelledFailure() => print('request cancelled'),
    ParseFailure() => print('unexpected response body'),
    UnknownFailure() => print('something else went wrong'),
  },
  (shows) => print('${shows.length} shows'),
);
```

Transient network problems (connection/send/receive timeouts, connection
errors) are retried automatically up to 3 times with exponential backoff
before being reported as a `NetworkFailure`.

### Custom configuration

```dart
final api = ItunesPodcastApi(
  customBaseUrl: 'https://itunes.apple.com', // optional override
  httpClient: myDioInstance,                 // optional, e.g. for interceptors/tests
);
```

## Additional information

- This client covers the podcast-related subset of the iTunes Search API
  (`media=podcast`) plus RSS feed parsing. Other media types (music, movies,
  books, ...) are out of scope.
- RSS parsing is powered by [rss_dart](https://pub.dev/packages/rss_dart);
  feeds are mapped onto this package's own models so the public API stays
  stable regardless of the underlying parser.
- The upstream API is rate limited to roughly **20 calls per minute**; add
  caching on your side for heavy workloads.
- The iTunes Search API responds with `Content-Type: text/javascript`; the
  client decodes such bodies transparently.
- This is an unofficial package and is not affiliated with Apple Inc.
