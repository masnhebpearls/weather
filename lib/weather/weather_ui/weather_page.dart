import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather/bloc/weather_event.dart';
import 'package:weather/weather/widgets/drawer_row.dart';
import 'package:weather/weather/widgets/weather_summary_row.dart';

import '../../colors/colors_constants.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_state.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key, required this.position});

  final Position position;

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final weatherBloc = WeatherBloc(position: widget.position)
      ..add(GetApiRequestCalled());
    return BlocProvider(
      create: (context) => weatherBloc,
      child: BlocConsumer<WeatherBloc, WeatherState>(
        listener: (context, state) {
          if (state is LocationExists){
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                backgroundColor: Colors.white,
                content: Text("Location already exists",
                style: summaryTextStyle.copyWith(
                    fontWeight: FontWeight.bold
                ),
                )));
          }
          if (state is LocationNotFound){
            ScaffoldMessenger.of(context).showSnackBar( SnackBar(
                backgroundColor: Colors.white,
                content: Text("Location not  found",
                style: summaryTextStyle.copyWith(
                  fontWeight: FontWeight.bold
                ),
                )));
          }

          // TODO: implement listener
        },
        builder: (context, state) {
          return BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              switch (state.runtimeType) {
                case (const (ApiLoadingState)):
                  return const Scaffold(
                    body: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case const (ApiSuccessState):
                  final currentIndex = state.index;
                  return Builder(
                      builder: (ctx) {
                        return Scaffold(
                            floatingActionButton: FloatingActionButton(
                              onPressed: () async {
                                showDialog<void>(
                                  context: context,
                                  barrierDismissible: true, // user must tap button!
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Add places'),
                                      content: TextField(
                                        controller: _controller,
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          child: const Text('Search'),
                                          onPressed: () {
                                            ctx.read<WeatherBloc>().add(SearchPlaces(value: _controller.text));
                                            _controller.clear();
                                            Navigator.of(context).pop();
                                          },
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: const Icon(FontAwesomeIcons.plus),
                            ),
                            drawer: Drawer(
                              child: Padding(
                                  padding: EdgeInsets.only(
                                      top: MediaQuery.of(context).size.height * 0.1),
                                  child: ListView.builder(
                                    itemCount: context.read<WeatherBloc>().weather.length,
                                    itemBuilder: (context, index) {
                                      return DrawerRow(
                                          currentIndex: index,
                                          location: context
                                              .read<WeatherBloc>()
                                              .weather[index]
                                              .name,
                                          context: context);
                                    },
                                  )),
                            ),
                            appBar: AppBar(
                              flexibleSpace: Container(
                                decoration:
                                const BoxDecoration(gradient: backGroundGradient),
                              ),
                              elevation: 0,
                            ),
                            body: buildWeatherUI(context,currentIndex));
                      }
                  );
                default:
                  return Scaffold(body: Container());
              }
            },
          );
        },
      ),
    );
  }

  Widget buildWeatherUI(BuildContext context, int index) {
    String getMonth(int month) {
      switch (month) {
        case (1):
          return "Jan";
        case (2):
          return "Feb";
        case (3):
          return "Mar";
        case (4):
          return "Apr";
        case (5):
          return "May";
        case (6):
          return "Jun";
        case (7):
          return "Jul";
        case (8):
          return "Aug";
        case (9):
          return "sept";
        case (10):
          return "Oct";
        case (11):
          return "Nov";
        case (12):
          return "Dec";
        default:
          return "Jan";
      }
    }

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: width,
            height: height * 0.35,
            decoration: BoxDecoration(
              gradient: backGroundGradient,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(width * 0.15),
                bottomRight: Radius.circular(width * 0.15),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(width * 0.075, 0, 0, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context
                        .read<WeatherBloc>()
                        .weather[context.read<WeatherBloc>().currentIndex]
                        .name,
                    style: cardTextStyle,
                  ),
                  SizedBox(
                    height: height * 0.0125,
                  ),
                  Text(
                    "${context.read<WeatherBloc>().weather[context.read<WeatherBloc>().currentIndex].localTime.substring(8, 10)} ${getMonth(int.parse(context.read<WeatherBloc>().weather[context.read<WeatherBloc>().currentIndex].localTime.substring(6, 7)))}",
                    style: cardTextStyle.copyWith(fontSize: 22),
                  ),
                  Center(
                      child: ImageIcon(
                        NetworkImage(
                          'https:${context.read<WeatherBloc>().weather[context.read<WeatherBloc>().currentIndex].imgUrl}',
                        ),
                        color: Colors.white,
                        size: height * 0.1,
                      )),
                  Center(
                    child: Text(
                      "${context.read<WeatherBloc>().weather[context.read<WeatherBloc>().currentIndex].tempC} C",
                      style: cardTextStyle.copyWith(fontSize: 32),
                    ),
                  ),
                  SizedBox(
                    height: height * 0.0025,
                  ),
                  Center(
                    child: Text(
                      context
                          .read<WeatherBloc>()
                          .weather[context.read<WeatherBloc>().currentIndex]
                          .weatherStatus,
                      style: cardTextStyle.copyWith(fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(width * 0.075, height * 0.035, 0, 0),
            child: Column(
              children: [
                WeatherSummaryRow(
                    width: width,
                    height: height,
                    firstIcon: FontAwesomeIcons.temperatureEmpty,
                    firstKeyword: "Feels like",
                    firstVal:
                    "${context.read<WeatherBloc>().weather[context.read<WeatherBloc>().currentIndex].feelsLikeC} C",
                    secondIcon: Icons.electric_meter,
                    secondKeyword: "Pressure",
                    secondVal:
                    "${context.read<WeatherBloc>().weather[context.read<WeatherBloc>().currentIndex].pressure} in"),
                WeatherSummaryRow(
                    width: width,
                    height: height,
                    firstIcon: FontAwesomeIcons.umbrella,
                    firstKeyword: "Precipitation",
                    firstVal:
                    "${context.read<WeatherBloc>().weather[context.read<WeatherBloc>().currentIndex].precipitation} mm",
                    secondIcon: FontAwesomeIcons.droplet,
                    secondKeyword: "Humidity",
                    secondVal:
                    "${context.read<WeatherBloc>().weather[context.read<WeatherBloc>().currentIndex].humidity} %"),
                WeatherSummaryRow(
                    width: width,
                    height: height,
                    firstIcon: FontAwesomeIcons.wind,
                    firstKeyword: "Wind",
                    firstVal:
                    "${context.read<WeatherBloc>().weather[context.read<WeatherBloc>().currentIndex].windKph} Kmph",
                    secondIcon: FontAwesomeIcons.diamondTurnRight,
                    secondKeyword: "Direction",
                    secondVal: context
                        .read<WeatherBloc>()
                        .weather[context.read<WeatherBloc>().currentIndex]
                        .windDirection),
                WeatherSummaryRow(
                    width: width,
                    height: height,
                    firstIcon: Icons.wind_power,
                    firstKeyword: "Wind Gust",
                    firstVal:
                    "${context.read<WeatherBloc>().weather[context.read<WeatherBloc>().currentIndex].gust} kmph",
                    secondIcon: Icons.sunny,
                    secondKeyword: "UV Index",
                    secondVal:
                    "${context.read<WeatherBloc>().weather[context.read<WeatherBloc>().currentIndex].uv}")
              ],
            ),
          )
          // Add more weather UI components here as needed
        ],
      ),
    );
  }
}