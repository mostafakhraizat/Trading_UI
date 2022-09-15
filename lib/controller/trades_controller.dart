import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sweet_snackbar/sweet_snackbar.dart';
import 'package:sweet_snackbar/top_snackbar.dart';
import 'package:uquitik_financials_task/model/trade.dart';

class TradesController extends GetxController {


  RxList<Trade> trades = RxList([]);
  RxList<Trade> searchHits = RxList([]);
  RxList<Trade> initialList = RxList([]);
  RxBool all = RxBool(true), rising = RxBool(false), dropping = RxBool(false);

  int risingCount = 0;
  int droppingCount = 0;
  TextEditingController symbolController = TextEditingController();
  TextEditingController ticketController = TextEditingController();
  GlobalKey<FormState> searchKey = GlobalKey();

  @override
  void onClose() {
    symbolController.dispose();
    ticketController.dispose();
    super.onClose();
  }

  @override
  void onInit() async {
    await readTrades();
    searchHits.value = trades.sublist(0, 10);
    update();
    super.onInit();
  }

  Future<RxList<Trade>> readTrades() async {
    final String response =
        await rootBundle.loadString('assets/data/Trades.json');
    Iterable l = jsonDecode(response);
    trades.value = List<Trade>.from(l.map((model) => Trade.fromJson(model)));
    trades.shuffle();
    initialList.value = trades.sublist(0, 10);
    risingCount = initialList
        .where((element) => !element.pROFIT!.isNegative)
        .toList()
        .length;
    droppingCount = initialList
        .where((element) => element.pROFIT!.isNegative)
        .toList()
        .length;
    update();
    return trades;
  }

  void setAll() {
    all.value = true;
    rising.value = false;
    dropping.value = false;
    update();
  }

  void setRising() {
    all.value = false;
    rising.value = true;
    dropping.value = false;
    update();
  }

  void setDropping() {
    all.value = false;
    rising.value = false;
    dropping.value = true;
    update();
  }

  String? ticketValidator(String? value) {
    if (value!.isEmpty) {
      return "Enter ticket value";
    } else {
      return null;
    }
  }

  String? symbolValidator(String? value) {
    if (value!.isEmpty) {
      return "Enter ticket value";
    } else {
      return null;
    }
  }

  void search(context) {
    if (symbolController.text.isEmpty && ticketController.text.isEmpty) {
      showTopSnackBar(context,
          const CustomSnackBar.info(message: 'Please enter Ticket or Symbol'));
    } else {
      searchHits.value.clear();
      searchHits.value = trades
          .where((element) =>
              (element.sYMBOL.toString().toUpperCase() ==
                      symbolController.text.toString().toUpperCase() ||
                  element.sYMBOL.toString().toUpperCase().startsWith(
                      symbolController.text.toString().toUpperCase())) &&
              element.tICKET
                  .toString()
                  .contains(ticketController.text.toString()))
          .toList();
      risingCount = searchHits
          .where((element) => !element.pROFIT!.isNegative)
          .toList()
          .length;
      droppingCount = searchHits
          .where((element) => element.pROFIT!.isNegative)
          .toList()
          .length;
    }

    update();
  }

  void clear() async {
    ticketController.clear();
    symbolController.clear();
    searchHits.value = trades.sublist(0, 10);
    risingCount = searchHits
        .where((element) => !element.pROFIT!.isNegative)
        .toList()
        .length;
    droppingCount = searchHits
        .where((element) => element.pROFIT!.isNegative)
        .toList()
        .length;
    update();
  }
}
