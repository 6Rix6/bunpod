import 'package:apple_podcast_api/apple_podcast_api.dart';
import 'package:bunpod/bunpod.dart';
import 'package:flutter/material.dart';

extension ItunesPodcastMapper on ItunesPodcast {
  Channel? toChannel() {
    final imageUrl =
        artworkUrl100 ?? artworkUrl60 ?? artworkUrl30 ?? artworkUrl600;

    final name =
        trackName ??
        trackCensoredName ??
        collectionName ??
        collectionCensoredName;

    if (feedUrl == null ||
        imageUrl == null ||
        name == null ||
        artistName == null) {
      return null;
    }

    return Channel(
      localId: -1, // no need localId for search result
      feedUrl: feedUrl!,
      name: name,
      host: artistName!,
      description: '',
      image: imageUrl,
      color: Colors.grey.toARGB32(),
    );
  }
}

extension FeedRowMapper on FeedRow {
  Future<Channel> toChannel(String host) async {
    final color = await ImageColorCache.of(imageUrl);

    return Channel(
      localId: id,
      feedUrl: url,
      name: title,
      host: host,
      color: color,
      image: imageUrl,
      description: description,
    );
  }
}
