import 'dart:developer';

import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final client = ItunesPodcastApi();
  final ampClient = ApplePodcastAmpApi();

  test('jwt', () async {
    final jwt = await ampClient.getJwt();

    if (jwt != null) {
      expect(ampClient.isJwtValid(jwt), isTrue);
    }
  });

  test('Search', () async {
    final res = await client.searchPodcasts('ゆる言語学');

    res.match((l) => fail(l.toString()), (r) {
      for (final item in r) {
        log(item.trackName ?? '');
      }
    });
  });
}
