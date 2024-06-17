class Weather {
  const Weather({required this.localTime , required this.weatherStatus,required this.imgUrl, required this.precipitation, required this.humidity, required this.uv, required this.gust, required this.pressure, required this.windDirection, required this.name, required this.tempC, required this.windKph, required this.feelsLikeC});
  final String name;
  final double tempC;
  final double feelsLikeC;
  final double windKph;
  final String imgUrl;
  final double precipitation;
  final int humidity;
  final double uv;
  final double gust;
  final double pressure;
  final String windDirection;
  final String weatherStatus;
  final String localTime;


}