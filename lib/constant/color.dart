import 'package:flutter/material.dart';


//COLOR
const Color white = Color(0xFFFFFFFF);
const Color yellow = Color(0xffFFD803);
const Color yellowDope = Color(0xffC7AD1F);
const Color black = Color(0xFF000000);
const Color blackText = Color(0xFF4D4D4D);
const Color blackTitle = Color(0xFF272343);
const Color blue = Color(0xFF248DDA);

//SHADOW
List<BoxShadow>? shadow3 = [
  BoxShadow(
    color: Color.fromRGBO(0, 0, 0, 0.04),
    blurRadius: 4.0,
    offset: Offset(0, 2),
  )
];

//GRADIENT
LinearGradient buttonGradient = LinearGradient(
    colors: [yellow, yellowDope],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight);