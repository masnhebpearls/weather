// // To parse this JSON data, do
// //
// //     final weatherClass = weatherClassFromJson(jsonString);
//
// import 'package:freezed_annotation/freezed_annotation.dart';
// import 'dart:convert';
//
// part 'weather_class.freezed.dart';
// part 'weather_class.g.dart';
//
// WeatherClass weatherClassFromJson(String str) => WeatherClass.fromJson(json.decode(str));
//
// String weatherClassToJson(WeatherClass data) => json.encode(data.toJson());
//
// @freezed
// class WeatherClass with _$WeatherClass {
//   const factory WeatherClass({
//     required Location location,
//     required Current current,
//   }) = _WeatherClass;
//
//   factory WeatherClass.fromJson(Map<String, dynamic> json) => _$WeatherClassFromJson(json);
// }
//
// @freezed
// class Current with _$Current {
//   const factory Current({
//     int? lastUpdatedEpoch,
//     String? lastUpdated,
//     int? tempC,
//     double? tempF,
//     int? isDay,
//     Condition? condition,
//     double? windMph,
//     double? windKph,
//     int? windDegree,
//     String? windDir,
//     int? pressureMb,
//     double? pressureIn,
//     int? precipMm,
//     int? precipIn,
//     int? humidity,
//     int? cloud,
//     double? feelslikeC,
//     double? feelslikeF,
//     double? windchillC,
//     double? windchillF,
//      int? heatindexC,
//      int? heatindexF,
//      double? dewpointC,
//      double? dewpointF,
//      int? visKm,
//      int? visMiles,
//      int? uv,
//      double? gustMph,
//      double? gustKph,
//   }) = _Current;
//
//   factory Current.fromJson(Map<String, dynamic> json) => _$CurrentFromJson(json);
// }
//
// @freezed
// class Condition with _$Condition {
//   const factory Condition({
//     required String text,
//     required String icon,
//     required int code,
//   }) = _Condition;
//
//   factory Condition.fromJson(Map<String, dynamic> json) => _$ConditionFromJson(json);
// }
//
// @freezed
// class Location with _$Location {
//   const factory Location({
//      String? name,
//      String? region,
//      String? country,
//      double? lat,
//      double? lon,
//      String? tzId,
//      String? localtime,
//   }) = _Location;
//
//   factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
// }
//
