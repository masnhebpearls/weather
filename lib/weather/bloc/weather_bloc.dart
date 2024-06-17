import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/class/weather.dart';
import 'package:weather/weather/bloc/weather_event.dart';
import 'package:weather/weather/bloc/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc({required this.position}) : super(ApiLoadingState(index: 0)) {

    on<GetApiRequestCalled>(getApiRequestCalled);
    on<SearchPlaces>(searchPlaces);
    on<LocationTapped>(locationTapped);

  }
  final Position position;
  List<Weather> weather=[];
  int currentIndex = 0;



  FutureOr<void> getApiRequestCalled(GetApiRequestCalled event, Emitter<WeatherState> emit) async {
    emit(ApiLoadingState(index: 0));
    try{
      final String url = 'http://api.weatherapi.com/v1/current.json?key=ab82b15d25a64de1a0b60109241406&q=${position.latitude},${position.longitude}&aqi=no';
      var response = await Dio().get(url);
      print(response);

      var decodedJson = json.decode(response.toString());
      weather.add(Weather(
        localTime: decodedJson['location']['localtime'],
        weatherStatus: decodedJson['current']['condition']['text'],
        imgUrl: decodedJson['current']['condition']['icon'],
        precipitation: decodedJson['current']['precip_mm'],
        humidity: decodedJson['current']['humidity'],
        uv: decodedJson['current']['uv'],
        gust: decodedJson['current']['gust_kph'],
        pressure: decodedJson['current']['pressure_in'],
        windDirection: decodedJson['current']['wind_dir'],
        name: decodedJson['location']['name'],
        tempC: decodedJson['current']['temp_c'],
        windKph: decodedJson['current']['wind_kph'],
        feelsLikeC: decodedJson['current']['feelslike_c'],
      ),
      );
      currentIndex= weather.length-1;
      print(currentIndex);


      emit(ApiSuccessState(index: currentIndex));

    }catch(e){
      print(e);
      emit(ApiFailedState(index: 0));
    }

  }

  FutureOr<void> searchPlaces(SearchPlaces event, Emitter<WeatherState> emit) async {
    try{
      final String url = 'http://api.weatherapi.com/v1/current.json?key=ab82b15d25a64de1a0b60109241406&q=${event.value}&aqi=no';
      var response = await Dio().get(url);
      print(response);
      var decodedJson = json.decode(response.toString());
      final newWeather = Weather(
        localTime: decodedJson['location']['localtime'],
        weatherStatus: decodedJson['current']['condition']['text'],
        imgUrl: decodedJson['current']['condition']['icon'],
        precipitation: decodedJson['current']['precip_mm'],
        humidity: decodedJson['current']['humidity'],
        uv: decodedJson['current']['uv'],
        gust: decodedJson['current']['gust_kph'],
        pressure: decodedJson['current']['pressure_in'],
        windDirection: decodedJson['current']['wind_dir'],
        name: decodedJson['location']['name'],
        tempC: decodedJson['current']['temp_c'],
        windKph: decodedJson['current']['wind_kph'],
        feelsLikeC: decodedJson['current']['feelslike_c'],
      );

      final check = weather.where((element)=>element.name == newWeather.name).toList();
      if (check.isEmpty){
        weather.add(newWeather);
        currentIndex= weather.length-1;
        emit(ApiSuccessState(index: currentIndex));

      }
      else{
        weather.remove(check.first);
        weather.add(newWeather);
        currentIndex= weather.length-1;
        emit(LocationExists(index: currentIndex));
        emit(ApiSuccessState(index: currentIndex));

      }

    }
    on DioException catch(e){
      if (e.response!.statusCode== 400){
        emit(LocationNotFound(index: currentIndex));
        emit(ApiSuccessState(index: currentIndex));

      }
      print(e);

    }



  }

  FutureOr<void> locationTapped(LocationTapped event, Emitter<WeatherState> emit) {
    currentIndex = event.index;
    emit(ApiSuccessState(index: currentIndex));
  }
}
