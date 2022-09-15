import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:uquitik_financials_task/controller/network_controller.dart';
import 'package:uquitik_financials_task/model/user_data.dart';

import '../constants/asset_api_paths.dart';
import '../view/signup/phone_signup.dart';

class SplashController extends GetxController {
  RxMap<String, dynamic> data = RxMap({});
  UserData userData = UserData();
  final NetworkController networkController = Get.find();


  void printIps(context) async {
    try {
      await http.get(Uri.parse(getNetworkUrl)).then((value) {
        Future.delayed(const Duration(seconds: 2), () {
          data.value = jsonDecode(value.body.toString());
          userData = UserData.fromJson(data);
          Navigator.of(context).push(MaterialPageRoute(builder: (c)=>PhoneSignupScreen()));
          update();
        });
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
  }
}
