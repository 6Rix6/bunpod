// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Episode _$EpisodeFromJson(Map<String, dynamic> json) => _Episode(
  localId: (json['localId'] as num).toInt(),
  guid: json['guid'] as String,
  bucket: $enumDecode(_$BucketEnumMap, json['bucket']),
  channel: json['channel'] as String,
  host: json['host'] as String,
  title: json['title'] as String,
  date: json['date'] as String,
  color: (json['color'] as num).toInt(),
  image: json['image'] as String,
  feedurl: json['feedurl'] as String,
  audioUrl: json['audioUrl'] as String,
  total: Duration(microseconds: (json['total'] as num).toInt()),
);

Map<String, dynamic> _$EpisodeToJson(_Episode instance) => <String, dynamic>{
  'localId': instance.localId,
  'guid': instance.guid,
  'bucket': _$BucketEnumMap[instance.bucket]!,
  'channel': instance.channel,
  'host': instance.host,
  'title': instance.title,
  'date': instance.date,
  'color': instance.color,
  'image': instance.image,
  'feedurl': instance.feedurl,
  'audioUrl': instance.audioUrl,
  'total': instance.total.inMicroseconds,
};

const _$BucketEnumMap = {
  Bucket.today: 'today',
  Bucket.yesterday: 'yesterday',
  Bucket.thisWeek: 'thisWeek',
  Bucket.thisMonth: 'thisMonth',
  Bucket.earlier: 'earlier',
};
