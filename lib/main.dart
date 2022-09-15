import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uquitik_financials_task/bindings/bindings.dart';
import 'constants/string_constants.dart';
import 'view/splash/splash_screen.dart';

void main() {
  MyBindings().dependencies();
runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: MyBindings(),
      debugShowCheckedModeBanner: false,
      title: title,
      theme: ThemeData.dark(),
      home:  SplashScreen(),
    );
  }
}

