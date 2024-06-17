
class WeatherState {
  final int index;

  WeatherState({required this.index});

}

class InitialHomePageState extends WeatherState {
  InitialHomePageState({required super.index});
}

class ApiSuccessState extends WeatherState {
  ApiSuccessState({required super.index});

}

class ApiDeclineState extends WeatherState{
  ApiDeclineState({required super.index});
}

class ApiNetworkState extends WeatherState {
  ApiNetworkState({required super.index});
}

class ApiLoadingState extends WeatherState {
  ApiLoadingState({required super.index});
}


class ApiFailedState extends WeatherState{
  ApiFailedState({required super.index});
}


class ApiResultNotFound extends WeatherState{
  ApiResultNotFound({required super.index});
}


class LocationExists extends WeatherState{
  LocationExists({required super.index});
}

class LocationNotFound extends WeatherState{
  LocationNotFound({required super.index});
}

class LoadedButNoInternet extends WeatherState{
  LoadedButNoInternet({required super.index});
}