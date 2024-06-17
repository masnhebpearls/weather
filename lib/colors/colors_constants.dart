import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const backGroundGradient =  LinearGradient(colors: [
  Color(0xff2d8fed),
  Color(0xff0f82f8),
  Color(0xff046bef)
],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight
);


const buttonGradient = LinearGradient(colors: [
  Color(0xff7aacda),
  Color(0xffaecde9),
  Color(0xffe5eff8)
],
    begin: Alignment.centerRight,
    end: Alignment.centerLeft
);


final TextStyle buttonTextStyle = GoogleFonts.lora(
fontSize: 22,
fontWeight: FontWeight.w700,
color: Colors.black
);

final TextStyle cardTextStyle = GoogleFonts.lora(
  fontSize: 26,
  fontWeight: FontWeight.bold,
  color: Colors.white
);

final TextStyle summaryTextStyle = GoogleFonts.lora(
    fontSize: 20,
    // fontWeight: FontWeight.bold,
    color: Colors.black
);