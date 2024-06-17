
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
