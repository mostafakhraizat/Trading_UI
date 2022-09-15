import 'package:get/get.dart';
import 'package:uquitik_financials_task/controller/trades_controller.dart';
import 'package:uquitik_financials_task/controller/signup_controller.dart';

import '../controller/network_controller.dart';
import '../controller/scroll_controller.dart';
import '../controller/splash_controller.dart';

class MyBindings implements Bindings
{
  @override
  void dependencies() {
    Get.lazyPut<SplashController>(()=>SplashController());
    Get.lazyPut<SignupController>(()=>SignupController());
    Get.lazyPut<TradesController>(()=>TradesController());
    Get.lazyPut<NetworkController>(()=>NetworkController());
    Get.lazyPut<ScrollingController>(()=>ScrollingController());

  }
}