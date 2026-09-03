import 'package:bunpod/bunpod.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'channel.freezed.dart';
part 'channel.g.dart';

/// A podcast channel. Its identity (name, host, seed, cover) is derived from the
/// episodes that belong to it — see [mockChannels] — so there is a single source
/// of truth. Only the editorial [description] is channel-level data.
@freezed
sealed class Channel with _$Channel {
  const factory Channel({
    required String name,
    required String host,
    required int color,
    required String image,
    required String description,
  }) = _Channel;

  factory Channel.fromJson(Map<String, dynamic> json) =>
      _$ChannelFromJson(json);
}

extension ChannelX on Channel {
  Color get seed => Color(color);

  /// Per-channel color scheme, mirroring [Episode.scheme] so the channel page
  /// tints to the same palette as its episodes.
  ColorScheme scheme(BuildContext context) => SchemeCache.of(context, color);

  /// Episodes that belong to this channel, in feed order.
  List<Episode> get episodes =>
      mockEpisodes.where((Episode e) => e.channel == name).toList();
}
