import 'package:bunpod/bunpod.dart';
import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode.freezed.dart';

@freezed
abstract class Episode with _$Episode {
  const factory Episode({
    required Bucket bucket,
    required String channel,
    required String host,
    required String title,
    required String date,
    required Color seed,
    required String image,

    /// Placeholder stream URL until real feed data arrives.
    required String audioUrl,
    required Duration total,
    required Duration listened,
    @Default(false) bool playing,
  }) = _Episode;
}

extension EpisodeX on Episode {
  /// Stable identifier across restarts (mock feeds have no GUID yet).
  String get id => '$channel|$title';

  double get progress =>
      total.inSeconds == 0 ? 0 : listened.inSeconds / total.inSeconds;

  ColorScheme scheme(BuildContext context) => ColorScheme.fromSeed(
    seedColor: seed,
    brightness: Theme.of(context).brightness,
    dynamicSchemeVariant: DynamicSchemeVariant.content,
  );
}
