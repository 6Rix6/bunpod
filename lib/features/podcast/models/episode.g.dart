// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'episode.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Episode _$EpisodeFromJson(Map<String, dynamic> json) => _Episode(
  bucket: $enumDecode(_$BucketEnumMap, json['bucket']),
  channel: json['channel'] as String,
  host: json['host'] as String,
  title: json['title'] as String,
  date: json['date'] as String,
  color: (json['color'] as num).toInt(),
  image: json['image'] as String,
  audioUrl: json['audioUrl'] as String,
  total: Duration(microseconds: (json['total'] as num).toInt()),
  listened: Duration(microseconds: (json['listened'] as num).toInt()),
);

Map<String, dynamic> _$EpisodeToJson(_Episode instance) => <String, dynamic>{
  'bucket': _$BucketEnumMap[instance.bucket]!,
  'channel': instance.channel,
  'host': instance.host,
  'title': instance.title,
  'date': instance.date,
  'color': instance.color,
  'image': instance.image,
  'audioUrl': instance.audioUrl,
  'total': instance.total.inMicroseconds,
  'listened': instance.listened.inMicroseconds,
};

const _$BucketEnumMap = {
  Bucket.today: 'today',
  Bucket.yesterday: 'yesterday',
  Bucket.thisWeek: 'thisWeek',
  Bucket.thisMonth: 'thisMonth',
  Bucket.earlier: 'earlier',
};
