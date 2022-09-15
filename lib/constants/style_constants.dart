import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uquitik_financials_task/constants/string_constants.dart';

InputDecoration textFieldInputDecoration = const InputDecoration(
  hintText: 'Enter a value',
  contentPadding: EdgeInsets.only(top: 30),
  fillColor: Color(0xF5F5F5FF),
  filled: true,
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xF5F5F5FF), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  errorBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xF5F5F5FF), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(0xF5F5F5FF), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(10.0)),
  ),
);

TextStyle bodyTextBoldBlack =  TextStyle(
    fontFamily: nunito,
    color: Get.isDarkMode?Colors.white:Colors.black,
    fontWeight: FontWeight.w900,
    fontSize: 22);
TextStyle bodyTextBoldGrey =  TextStyle(
    fontFamily: nunito,
    fontWeight: FontWeight.w900,
    fontSize: 18);
TextStyle bodyTextBoldBlue =  TextStyle(
    fontFamily: nunito,
    fontWeight: FontWeight.bold,
    fontSize: 22);
TextStyle bodyTextNormal =  TextStyle(
    fontFamily: nunito,
    fontSize: 14);

TextStyle bodyTextNormalBlue =   TextStyle(
    fontFamily: nunito,
    fontSize: 14);





TextStyle buttonText =  TextStyle(
    fontFamily: nunito,
    fontWeight: FontWeight.w800,
    fontSize: 16);
TextStyle buttonTextGrey =   TextStyle(
    fontFamily: nunito,
    fontWeight: FontWeight.w800,
    fontSize: 16);
