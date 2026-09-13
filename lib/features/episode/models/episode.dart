import 'package:bunpod/bunpod.dart';
import 'package:flutter/material.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'episode.freezed.dart';
part 'episode.g.dart';

@freezed
abstract class Episode with _$Episode {
  const factory Episode({
    required int localId, // id of EpisodeRow
    required String guid,
    required Bucket bucket,
    required String channel,
    required String host,
    required String title,
    required String date,
    required int color,
    required String image,
    required String feedurl,
    required String audioUrl,
    required Duration total,
  }) = _Episode;

  factory Episode.fromJson(Map<String, dynamic> json) =>
      _$EpisodeFromJson(json);
}

extension EpisodeX on Episode {
  String get id => '$channel|$title';

  Color get seed => Color(color);
  ColorScheme scheme(BuildContext context) => SchemeCache.of(context, color);
}
