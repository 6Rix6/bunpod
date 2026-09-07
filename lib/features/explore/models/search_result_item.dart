import 'package:bunpod/bunpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'search_result_item.freezed.dart';
part 'search_result_item.g.dart';

@freezed
sealed class SearchResultItem with _$SearchResultItem {
  const factory SearchResultItem({
    required Channel channel,
    required String feedUrl,
  }) = _SearchResultItem;

  factory SearchResultItem.fromJson(Map<String, dynamic> json) =>
      _$SearchResultItemFromJson(json);
}
