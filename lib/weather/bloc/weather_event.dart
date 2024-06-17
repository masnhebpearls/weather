
abstract class WeatherEvent{}

class GetApiRequestCalled extends WeatherEvent {}


class SearchPlaces extends WeatherEvent {
  final String value;

  SearchPlaces({required this.value});
}


class LocationTapped extends WeatherEvent {
  final int index;

  LocationTapped({required this.index});

}