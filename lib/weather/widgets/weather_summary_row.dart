import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../colors/colors_constants.dart';


class WeatherSummaryRow extends StatelessWidget {
  const WeatherSummaryRow({super.key, required this.width , required this.height, required this.firstIcon, required this.firstKeyword , required this.firstVal, required this.secondIcon, required this.secondKeyword, required this.secondVal});
  final double width;
  final double height;
  final IconData firstIcon;
  final IconData secondIcon;
  final String firstKeyword;
  final String secondKeyword;
  final String firstVal;
  final String secondVal;

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: EdgeInsets.fromLTRB(0,0, width*0.075,height*0.025),
      child: Row(
        children: [
          Icon(firstIcon,size: 35,color: const Color(0xff046bef),),
          SizedBox(
            width: width*0.0125,
          ),
          SizedBox(
            width: width*0.325,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(firstKeyword, style: summaryTextStyle,),
                Text(firstVal, style: summaryTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),)
              ],
            ),
          ),
          const Spacer(),
          Icon(secondIcon,size: 35,color: const Color(0xff046bef),),
          SizedBox(
            width: width*0.0125,
          ),
          SizedBox(
            width: width*0.3,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(secondKeyword, style: summaryTextStyle,),
                Text(secondVal, style: summaryTextStyle.copyWith(fontSize: 18, fontWeight: FontWeight.bold),)
              ],
            ),
          ),

        ],
      ),
    );
  }
}
