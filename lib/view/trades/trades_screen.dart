import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:fswitch_nullsafety/fswitch_nullsafety.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:uquitik_financials_task/config/routing.dart';
import 'package:uquitik_financials_task/controller/network_controller.dart';
import 'package:uquitik_financials_task/controller/splash_controller.dart';

import '../../constants/string_constants.dart';
import '../../constants/style_constants.dart';
import '../../controller/trades_controller.dart';
import 'all_hits.dart';

class TradingScreen extends StatelessWidget {
  TradingScreen({Key? key}) : super(key: key);
  final TradesController homeController = Get.find();
  final SplashController splashController = Get.find();
  final NetworkController networkController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        bottomNavigationBar: GetBuilder<NetworkController>(
          init: networkController,
          builder: (GetxController controller) {
            if (networkController.connectionType.value == 0) {
              return Card(
                elevation: 8,
                child: SizedBox(
                  height: 42,
                  width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: Row(
                      children: [
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          "You're offline",
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red,
                                  fontFamily: nunito),
                        ),
                        const SizedBox(
                          width: 12,
                        ),
                        const Icon(
                          CupertinoIcons.wifi_slash,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                ),
              );
            } else {
              return Container(
                height: 0,
              );
            }
          },
        ),
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Get.isDarkMode ? Colors.grey[900] : Colors.white,
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FSwitch(
                onChanged: (bool value) {
                  if (Get.isDarkMode) {
                    Get.changeTheme(ThemeData.light());
                  } else if (!Get.isDarkMode) {
                    Get.changeTheme(ThemeData.dark());
                  }
                },
                open: Get.isDarkMode,
                enable: true,
                shadowColor: Colors.black.withOpacity(0.5),
                shadowBlur: 3.0,
                closeChild: const Icon(Icons.wb_sunny),
                openChild:  const Icon(Icons.dark_mode),
                width: 72,
                height: 32,
                openColor: Colors.grey[600],
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      trades,
                      style: Theme.of(context).textTheme.displaySmall!.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: nunito),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 36,
                width: 36,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: GetBuilder<SplashController>(
                      init: SplashController(),
                      builder: (controller) {
                        return Image.asset(
                          'icons/flags/png/${controller.userData.countryCode.toString().toLowerCase()}.png',
                          package: 'country_icons',
                          fit: BoxFit.cover,
                        );
                      }),
                ),
              ),
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Card(
                      elevation: 1,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: ExpandableNotifier(
                          initialExpanded: false,
                          child: Column(children: <Widget>[
                            ScrollOnExpand(
                                scrollOnExpand: true,
                                scrollOnCollapse: false,
                                child: ExpandablePanel(
                                    theme: ExpandableThemeData(
                                      headerAlignment:
                                          ExpandablePanelHeaderAlignment.center,
                                      tapBodyToCollapse: false,
                                      collapseIcon: Icons.arrow_drop_up,
                                      iconColor: Get.isDarkMode
                                          ? Colors.white
                                          : Colors.black,
                                      expandIcon: Icons.arrow_drop_down,
                                    ),
                                    header: Padding(
                                      padding: const EdgeInsets.only(left: 20),
                                      child: Row(
                                        children: [
                                          const Icon(IconlyLight.search),
                                          const SizedBox(
                                            width: 12,
                                          ),
                                          Text(
                                            searchTrades,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText1!
                                                .copyWith(
                                                    fontFamily: nunito,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                        ],
                                      ),
                                    ),
                                    collapsed: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    expanded: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      child: Card(
                                        elevation: 0,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                        ),
                                        child: Form(
                                          key: homeController.searchKey,
                                          child: Column(
                                            children: <Widget>[
                                              Container(
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0.2))),
                                                child: TextFormField(
                                                  validator: homeController
                                                      .ticketValidator,
                                                  controller: homeController
                                                      .ticketController,
                                                  textInputAction:
                                                      TextInputAction.next,
                                                  decoration: InputDecoration(
                                                      prefixIcon: const Icon(
                                                          CupertinoIcons
                                                              .ticket),
                                                      border: InputBorder.none,
                                                      hintText: ticket,
                                                      hintStyle:
                                                          Theme.of(context)
                                                              .textTheme
                                                              .bodyText1!
                                                              .copyWith(
                                                                  fontFamily:
                                                                      nunito,
                                                                  color: Colors
                                                                      .grey)),
                                                ),
                                              ),
                                              Container(
                                                decoration: const BoxDecoration(
                                                    border: Border(
                                                        bottom: BorderSide(
                                                            width: 0.2))),
                                                padding:
                                                    const EdgeInsets.all(4.0),
                                                child: TextFormField(
                                                  textInputAction:
                                                      TextInputAction.done,
                                                  controller: homeController
                                                      .symbolController,
                                                  validator: homeController
                                                      .symbolValidator,
                                                  decoration: InputDecoration(
                                                    prefixIcon: const Icon(
                                                        CupertinoIcons
                                                            .arrow_2_circlepath),
                                                    border: InputBorder.none,
                                                    hintText: symbol,
                                                    hintStyle: Theme.of(context)
                                                        .textTheme
                                                        .bodyText1!
                                                        .copyWith(
                                                            fontFamily: nunito,
                                                            color: Colors.grey),
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      homeController
                                                          .search(context);
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    child: Row(
                                                      children: [
                                                        const Icon(
                                                            IconlyLight.search),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Text(
                                                          search,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        nunito,
                                                                  ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  Container(
                                                    height: 50,
                                                    width: 0.2,
                                                    color: Get.isDarkMode
                                                        ? Colors.white
                                                        : Colors.black,
                                                  ),
                                                  InkWell(
                                                    onTap: () {
                                                      homeController.clear();
                                                      FocusScope.of(context)
                                                          .unfocus();
                                                    },
                                                    child: Center(
                                                        child: Row(
                                                      children: [
                                                        const Icon(
                                                            IconlyLight.delete),
                                                        const SizedBox(
                                                          width: 12,
                                                        ),
                                                        Text(
                                                          clear,
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .bodyText1!
                                                                  .copyWith(
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                    fontFamily:
                                                                        nunito,
                                                                  ),
                                                        ),
                                                      ],
                                                    )),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    builder: (_, collapsed, expanded) {
                                      return Expandable(
                                        collapsed: collapsed,
                                        expanded: expanded,
                                        theme: const ExpandableThemeData(
                                            crossFadePoint: 0),
                                      );
                                    }))
                          ])),
                    ),
                    const SizedBox(
                      height: 32,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        GetBuilder<TradesController>(builder: (controller) {
                          if (controller.searchHits.length > 25) {
                            return Text(
                              '${watchListCount + controller.searchHits.length.toString()} ) ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: nunito,
                                  ),
                            );
                          } else {
                            return Text(
                              '${watchList + controller.searchHits.length.toString()} ) ',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: nunito,
                                  ),
                            );
                          }
                        }),
                        InkWell(
                            onTap: () {
                              Navigator.of(context).push(
                                  CustomRouting().createRoute(AllHitsPage()));
                            },
                            child: Text(
                              seeAll,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: nunito,
                                  ),
                            )),
                      ],
                    ),
                    const SizedBox(
                      height: 4,
                    ),
                    const Divider(
                      height: 1,
                    ),
                  ],
                ),
              ),
              GetBuilder<TradesController>(builder: (controller) {
                if (controller.searchHits.isEmpty) {
                  return Center(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            height: 52,
                            width: 52,
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey3,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Center(
                              child: Icon(
                                IconlyLight.search,
                                color: Colors.grey[800],
                                size: 26,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            noResults,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: nunito),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'No results found for Ticket "${controller.ticketController.text.toString()}"\nand Symbol "${controller.symbolController.text.toString()}"',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: nunito),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.searchHits.length > 25
                        ? controller.searchHits.sublist(0, 24).length
                        : controller.searchHits.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Column(
                        children: [
                          Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(0)),
                            child: ExpandableNotifier(
                                initialExpanded: false,
                                child: Column(children: <Widget>[
                                  ScrollOnExpand(
                                      scrollOnExpand: true,
                                      scrollOnCollapse: false,
                                      child: ExpandablePanel(
                                          theme: ExpandableThemeData(

                                            headerAlignment:
                                                ExpandablePanelHeaderAlignment
                                                    .center,
                                            tapBodyToCollapse: true,
                                            collapseIcon: Icons.arrow_drop_up,
                                            iconColor: Get.isDarkMode
                                                ? Colors.white
                                                : Colors.black,
                                            expandIcon: Icons.arrow_drop_down,
                                          ),
                                          header: Padding(
                                              padding: const EdgeInsets.all(10),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  IconButton(icon: Icon(Icons.abc),onPressed: (){
                                                    print('steve');
                                                  },tooltip: 'steve',),
                                                  Row(
                                                    children: [
                                                      Text(
                                                        controller.searchHits
                                                            .elementAt(index)
                                                            .sYMBOL
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyLarge!
                                                            .copyWith(
                                                                fontFamily:
                                                                    nunito,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold),
                                                      ),
                                                      const SizedBox(
                                                        width: 12,
                                                      ),
                                                      const Icon(
                                                        CupertinoIcons
                                                            .ticket_fill,
                                                        color: Colors.grey,
                                                        size: 16,
                                                      ),
                                                      const SizedBox(
                                                        width: 4,
                                                      ),
                                                      Text(
                                                        controller.searchHits
                                                            .elementAt(index)
                                                            .tICKET
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .bodyMedium!
                                                            .copyWith(
                                                                fontFamily:
                                                                    nunito,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Colors
                                                                    .grey),
                                                      )
                                                    ],
                                                  ),
                                                  const SizedBox(
                                                    height: 6,
                                                  ),
                                                  Builder(builder: (context) {
                                                    if (controller.searchHits
                                                        .elementAt(index)
                                                        .pROFIT!
                                                        .isNegative) {
                                                      return Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const GlowIcon(
                                                            Icons
                                                                .arrow_downward,
                                                            color: Colors.red,
                                                            size: 16,
                                                            glowColor: Colors.red,
                                                            offset: Offset(1, -1),
                                                          ),
                                                          const SizedBox(
                                                            width: 6,
                                                          ),
                                                          Text(
                                                            ("${controller.searchHits.elementAt(index).pROFIT!.toStringAsFixed(2)} %"),
                                                            style: bodyTextNormal
                                                                .copyWith(
                                                                    fontFamily:
                                                                        nunito,
                                                                    color: Colors
                                                                        .red),
                                                          ),
                                                          const SizedBox(
                                                            width: 12,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                border:
                                                                    Border.all(
                                                                        width:
                                                                            1)),
                                                            child: Center(
                                                                child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 3,
                                                                  horizontal:
                                                                      6),
                                                              child: Text(
                                                                'VOL ${controller.searchHits.elementAt(index).vOLUME.toString()}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        fontFamily:
                                                                            nunito,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              ),
                                                            )),
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                border:
                                                                    Border.all(
                                                                        width:
                                                                            1)),
                                                            child: Center(
                                                                child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 3,
                                                                  horizontal:
                                                                      6),
                                                              child: Text(
                                                                'CMD ${controller.searchHits.elementAt(index).cMD.toString()}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        fontFamily:
                                                                            nunito,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              ),
                                                            )),
                                                          ),
                                                        ],
                                                      );
                                                    } else {
                                                      return Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          const GlowIcon(
                                                            Icons.arrow_upward,
                                                            color: Colors.green,
                                                            size: 16,
                                                            glowColor: Colors.green,
                                                            offset: Offset(1, -1),
                                                          ),
                                                          const SizedBox(
                                                            width: 6,
                                                          ),
                                                          Text(
                                                            ("${controller.searchHits.elementAt(index).pROFIT!.toStringAsFixed(2)} %"),
                                                            style: bodyTextNormal
                                                                .copyWith(
                                                                    fontFamily:
                                                                        nunito,
                                                                    color: Colors
                                                                        .green),
                                                          ),
                                                          const SizedBox(
                                                            width: 12,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                border:
                                                                    Border.all(
                                                                        width:
                                                                            1)),
                                                            child: Center(
                                                                child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 3,
                                                                  horizontal:
                                                                      6),
                                                              child: Text(
                                                                'VOL ${controller.searchHits.elementAt(index).vOLUME.toString()}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        fontFamily:
                                                                            nunito,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              ),
                                                            )),
                                                          ),
                                                          const SizedBox(
                                                            width: 4,
                                                          ),
                                                          Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            2),
                                                                border:
                                                                    Border.all(
                                                                        width:
                                                                            1)),
                                                            child: Center(
                                                                child: Padding(
                                                              padding: const EdgeInsets
                                                                      .symmetric(
                                                                  vertical: 3,
                                                                  horizontal:
                                                                      6),
                                                              child: Text(
                                                                'CMD ${controller.searchHits.elementAt(index).cMD.toString()}',
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .bodySmall!
                                                                    .copyWith(
                                                                        fontFamily:
                                                                            nunito,
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              ),
                                                            )),
                                                          ),
                                                        ],
                                                      );
                                                    }
                                                  })
                                                ],
                                              )),
                                          collapsed: const Padding(
                                            padding: EdgeInsets.only(),
                                          ),
                                          expanded: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceAround,
                                              children: [
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color: Colors.green),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8),
                                                        child: Text(
                                                          open,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  nunito,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .trades
                                                              .elementAt(index)
                                                              .oPENPRICE!
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: bodyTextNormalBlue
                                                              .copyWith(
                                                                  fontFamily:
                                                                      nunito,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .green),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .trades
                                                              .elementAt(index)
                                                              .oPENTIME
                                                              .toString(),
                                                          style: bodyTextNormalBlue
                                                              .copyWith(
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .green,
                                                                  fontFamily:
                                                                      nunito),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(4),
                                                          color: Colors.red),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .symmetric(
                                                                horizontal: 8),
                                                        child: Text(
                                                          close,
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  nunito,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 6,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .trades
                                                              .elementAt(index)
                                                              .cLOSEPRICE!
                                                              .toStringAsFixed(
                                                                  2),
                                                          style: bodyTextNormalBlue
                                                              .copyWith(
                                                                  fontFamily:
                                                                      nunito,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      children: [
                                                        Text(
                                                          controller
                                                              .trades
                                                              .elementAt(index)
                                                              .cLOSETIME
                                                              .toString(),
                                                          style: bodyTextNormalBlue
                                                              .copyWith(
                                                                  fontFamily:
                                                                      nunito,
                                                                  fontSize: 14,
                                                                  color: Colors
                                                                      .red),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ),
                                          builder: (_, collapsed, expanded) {
                                            return Expandable(
                                              collapsed: collapsed,
                                              expanded: expanded,
                                              theme: const ExpandableThemeData(
                                                  crossFadePoint: 0),
                                            );
                                          }))
                                ])),
                          ),
                          const Divider(height: 1)
                        ],
                      );
                    },
                  );
                }
              })
            ],
          ),
        ),
      ),
    );
  }
}
