import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScrollingController extends GetxController{
   ScrollController allHitsScrollController = ScrollController();
   // ScrollController tradesScrollController = ScrollController();
  bool showBackToTopButtonAll = false;
  bool showBackToTopButtonTrades = false;
  @override
  void onClose() {
    allHitsScrollController.dispose();
    // tradesScrollController.dispose();

    super.onClose();
  }
  @override
  void onInit() {
    //
    // tradesScrollController = ScrollController()
    //   ..addListener(() {
    //     if (tradesScrollController.offset >= 200) {
    //       showBackToTopButtonTrades = true;
    //     } else {
    //       showBackToTopButtonTrades = false;
    //     }
    //     update();
    //   });
    allHitsScrollController = ScrollController()
      ..addListener(() {
          if (allHitsScrollController.offset >= 200) {
            showBackToTopButtonAll = true;
          } else {
            showBackToTopButtonAll = false;
          }
          update();
      });

    // TODO: implement onInit
    super.onInit();
  }

  void scrollAllHitsToTop() async{
    allHitsScrollController.animateTo(0,
        duration: const Duration(milliseconds: 400), curve: Curves.linear);
  }


  //
  // void scrollTradesToTop() {
  //   tradesScrollController.animateTo(0,
  //       duration: const Duration(milliseconds: 400), curve: Curves.linear);
  // }




}