import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class NetworkController extends GetxController {
  RxInt connectionType = RxInt(-1);
  Connectivity connectivity = Connectivity();
  late StreamSubscription streamSubscription;

  @override
  void onInit() {
    getConnectionType();
    Connectivity().onConnectivityChanged.listen((event) {

      updateState(event);
      update();
    });
    super.onInit();
  }

  Future<void> getConnectionType() async {
    ConnectivityResult? connectionResult;
    try {
      connectionResult = await (connectivity.checkConnectivity());
    } on PlatformException catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return updateState(connectionResult!);
  }

  updateState(ConnectivityResult result) {
    if (result == ConnectivityResult.wifi) {
      connectionType.value = 1;
      update();
    } else if (result == ConnectivityResult.mobile) {
      connectionType.value = 2;
      update();
    } else if (result == ConnectivityResult.none) {
      connectionType.value = 0;
      update();
    } else {

    }
  }

  @override
  void onClose() {

  }
}
