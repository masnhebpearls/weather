import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'location_event.dart';
import 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  LocationBloc() : super(LocationInitialState()) {
    on<GetLocation>(getLocation);
  }
  Position? position;


  FutureOr<void> getLocation(GetLocation event, Emitter<LocationState> emit) async {
    emit(LocationLoadingState());


    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      emit(LocationOffState());
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied){
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied){
        emit(LocationPermissionDenied());
      }
    }
    if (permission == LocationPermission.deniedForever){
      emit(LocationPermissionDeniedForever());
    }

    Position currentPosition = await Geolocator.getCurrentPosition();

    position = currentPosition;
    print("position is $position");
    emit(LocationSuccessState());



  }
}
