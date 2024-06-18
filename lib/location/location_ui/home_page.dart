import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/colors/colors_constants.dart';
import 'package:weather/location/location/location_bloc.dart';
import 'package:weather/location/location/location_event.dart';
import 'package:weather/location/location/location_state.dart';

import '../../weather/weather_ui/weather_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    final LocationBloc locationBloc = LocationBloc();

    return  BlocProvider(
  create: (context) => LocationBloc(),
  child: Scaffold(

      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: backGroundGradient
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [

              Padding(
                padding: EdgeInsets.only(left: width*0.125),
                child: SizedBox(
                  width: width*0.75,
                  height: height*0.3,
                  child: FittedBox(
                    fit: BoxFit.cover,
                    child: Image.asset('images/weather.gif'),
                  ),
                ),
              ),
              SizedBox(height: height*0.05,),
              Padding(
                padding: EdgeInsets.only(left: width*0.15),
                child: InkWell(
                  onTap: (){
                    locationBloc.add(GetLocation());
                  },

                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(width*0.075),
                        gradient: buttonGradient,

                    ),
                    width: width*0.7,
                    height: height*0.075,
                    child:  Center(
                      child: BlocConsumer(
                        bloc: locationBloc,
                          listener: (context,state){
                          if (state is LocationSuccessState){
                            Navigator.pushAndRemoveUntil(context,
                                MaterialPageRoute(builder: (context) => WeatherPage(position: locationBloc.position!)),
                                (route)=> false);
                          }
                          },
                          builder: (context, state){
                          print("state is ${state.runtimeType}");
                          switch(state.runtimeType){
                            case(const (LocationInitialState)):
                              return Text("Get your location",
                                style: buttonTextStyle,
                              );
                            case (const (LocationLoadingState)):
                              return const CircularProgressIndicator();
                            case (const (LocationSuccessState)):
                              return Text(locationBloc.position.toString());
                            case (const (LocationOffState)):
                              return Text("location is off", style: buttonTextStyle,);
                            case (const (LocationPermissionDeniedForever)):
                              return Text("location is off forever", style: buttonTextStyle,);
                            case (const (LocationPermissionDenied)):
                              return Text("Location denied", style: buttonTextStyle,);
                            default:
                              return const Text('error');
                          }
                          },

                    ),
                  ),
                ),
              )
              ),],

          ),
        ],
      ),
    ),
);
  }
}



/*
BlocBuilder<LocationBloc, LocationState>(
                        buildWhen: (previous, current) => current is! LocationInitialState,
                        builder: (context, state) {
                          print("state is ${state.runtimeType}");
                            if (state is LocationInitialState){
                              return Text("Get your location",
                              style: GoogleFonts.lora(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Colors.black
                              ),
                              );
                            }
                            else if (state is LocationLoadingState){
                              return const CircularProgressIndicator();
                            }
                            else if (state is LocationSuccessState){
                              return Text(locationBloc.position.toString());
                            }
                            else {
                              return const Text("Null");
                            }
  },
),
 */


