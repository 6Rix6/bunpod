import 'package:bunpod/bunpod.dart';
import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode.freezed.dart';
part 'episode.g.dart';

@freezed
abstract class Episode with _$Episode {
  const factory Episode({
    required Bucket bucket,
    required String channel,
    required String host,
    required String title,
    required String date,
    required int color,
    required String image,

    /// Placeholder stream URL until real feed data arrives.
    required String audioUrl,
    required Duration total,
    required Duration listened,
  }) = _Episode;

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
}

extension EpisodeX on Episode {
  /// Stable identifier across restarts (mock feeds have no GUID yet).
  String get id => '$channel|$title';

  double get progress =>
      total.inSeconds == 0 ? 0 : listened.inSeconds / total.inSeconds;

  Color get seed => Color(color);
  ColorScheme scheme(BuildContext context) => seed.scheme(context);
}
