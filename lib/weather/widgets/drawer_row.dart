import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/weather/bloc/weather_bloc.dart';
import 'package:weather/weather/bloc/weather_event.dart';

import '../../colors/colors_constants.dart';

class DrawerRow extends StatelessWidget {
  const DrawerRow({super.key, required this.currentIndex, required this.location, required this.context});
  final int currentIndex;
  final String location;
  final BuildContext context;

  @override
  Widget build(context) {
    return  InkWell(
      onTap: (){
        context.read<WeatherBloc>().add(LocationTapped(index: currentIndex));
        Navigator.of(context).pop();
      },
      child: Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).size.height*0.0125),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width*0.05,
            ),
            const Icon(FontAwesomeIcons.locationPin, size: 25,),
            SizedBox(
              width: MediaQuery.of(context).size.width*0.05,
            ),
            Text(currentIndex==0 ? "Current Location": location.length> 15 ?'${location.substring(0,15)} ...': location, style: summaryTextStyle,)
          ],

        ),
      ),
    );
  }
}
