// To parse this JSON data, do
//
//     final weatherClass = weatherClassFromMap(jsonString);

import 'package:meta/meta.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'dart:convert';

part 'weather_class.freezed.dart';
part 'weather_class.g.dart';


@freezed
class WeatherClass with _$WeatherClass {
  const factory WeatherClass({
    required Location location,
    required Current current,
  }) = _WeatherClass;

  factory WeatherClass.fromJson(Map<String, dynamic> json) => _$WeatherClassFromJson(json);
}

@freezed
class Current with _$Current {
  const factory Current({
    required int lastUpdatedEpoch,
    required String lastUpdated,
    required int tempC,
    required double tempF,
    required int isDay,
    required Condition condition,
    required double windMph,
    required double windKph,
    required int windDegree,
    required String windDir,
    required int pressureMb,
    required double pressureIn,
    required int precipMm,
    required int precipIn,
    required int humidity,
    required int cloud,
    required double feelslikeC,
    required double feelslikeF,
    required double windchillC,
    required double windchillF,
    required int heatindexC,
    required int heatindexF,
    required double dewpointC,
    required double dewpointF,
    required int visKm,
    required int visMiles,
    required int uv,
    required double gustMph,
    required double gustKph,
  }) = _Current;

  factory Current.fromJson(Map<String, dynamic> json) => _$CurrentFromJson(json);
}

@freezed
class Condition with _$Condition {
  const factory Condition({
    required String text,
    required String icon,
    required int code,
  }) = _Condition;

  factory Condition.fromJson(Map<String, dynamic> json) => _$ConditionFromJson(json);
}

@freezed
class Location with _$Location {
  const factory Location({
    required String name,
    required String region,
    required String country,
    required double lat,
    required double lon,
    String? tzId,
    int? localtimeEpoch,
    String? localtime,
  }) = _Location;

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
}
