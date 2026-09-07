import 'package:bunpod/bunpod.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'explore_item.freezed.dart';
part 'explore_item.g.dart';

@freezed
sealed class ExploreItem with _$ExploreItem {
  const ExploreItem._();

  const factory ExploreItem.host({
    required String name,
    required int color,
    required List<Channel> channels,
  }) = ExploreHost;

  const factory ExploreItem.category({
    required String name,
    required int color,
    required List<Channel> channels,
  }) = ExploreCategory;

  factory ExploreItem.fromJson(Map<String, dynamic> json) =>
      _$ExploreItemFromJson(json);

  ColorScheme scheme(BuildContext context) => SchemeCache.of(context, color);
}
