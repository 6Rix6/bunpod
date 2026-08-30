import 'dart:developer';

import 'package:bunpod/bunpod.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  test('feed repository', () async {
    final datasource = RSSPodcastDataSourceImpl();
    final repository = PodcastFeedRepositoryImpl(datasource);

    final result = await repository.fetchFeeds();

    result.match((l) => fail('expect success: $l'), (r) {
      for (var feed in r) {
        log(feed.channel.name);
      }
    });
  });
}
