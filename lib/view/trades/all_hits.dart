import 'package:expandable/expandable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_glow/flutter_glow.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:uquitik_financials_task/controller/scroll_controller.dart';

import '../../constants/string_constants.dart';
import '../../constants/style_constants.dart';
import '../../controller/network_controller.dart';
import '../../controller/trades_controller.dart';

class AllHitsPage extends StatelessWidget {
  AllHitsPage({Key? key}) : super(key: key);
  final TradesController controller = Get.find();
  final NetworkController networkController = Get.find();
  final ScrollingController scrollingController = Get.find();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          floatingActionButton: GetBuilder<ScrollingController>(builder: (GetxController controller) {
            if(scrollingController.showBackToTopButtonAll){
               return  FloatingActionButton(
                 elevation: 2,
                 backgroundColor: Get.isDarkMode?Colors.grey[700]:Colors.grey[200],
                 onPressed: () {
                 scrollingController.scrollAllHitsToTop();
               },
                 child:  Icon(Icons.arrow_upward,color: Get.isDarkMode?Colors.grey[200]:Colors.grey[900]),

               );
            }else{
              return Container();
            }
          },),
          bottomNavigationBar: GetBuilder<NetworkController>(
            init: networkController,
            builder: (GetxController controller) {
              if(networkController.connectionType.value==0){
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
                            offline,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(fontWeight: FontWeight.bold,
                                color: Colors.red
                            ),
                          ),
                          const SizedBox(
                            width: 12,
                          ),
                          const Icon(CupertinoIcons.wifi_slash,color: Colors.red  ,)
                        ],
                      ),
                    ),
                  ),
                );
              }else{
                return Container(height: 0,);
              }
            },),
          body: Column(
        children: [
          Card(
            elevation: 0,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Icon(CupertinoIcons.back),
                    ),
                  ),
                  const SizedBox(
                    width: 32,
                  ),
                  Text(
                    'All Hits - ${controller.searchHits.length}',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ),
          Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8,horizontal: 4),
              child: GetBuilder<TradesController>(builder: (controller) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    InkWell(
                      onTap: () {
                        controller.setAll();
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Center(
                          child: Text(
                            all,
                            style: controller.all.value
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)
                                : Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.setRising();
                      },
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                              child: Text(
                            "$rising ${controller.risingCount.toString()}",
                            style: controller.rising .value
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)
                                : Theme.of(context).textTheme.bodyText1,
                          )),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        controller.setDropping();
                      },
                      child: Container(
                        height: 42,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(14)),
                        child: Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Center(
                              child: Text(
                                "$dropping ${controller.droppingCount.toString()}",
                            style: controller.dropping .value
                                ? Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16)
                                : Theme.of(context).textTheme.bodyText1,
                          )),
                        ),
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          Expanded(
            child: GetBuilder<TradesController>(builder: (controller) {
              if (controller.searchHits.isEmpty) {
                return  Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:  [
                    Container(
                      height: 52,
                      width: 52,
                      decoration: BoxDecoration(
                        color: CupertinoColors.systemGrey3,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Center(child: Icon(IconlyLight.search,color: Colors.grey[800],size: 26,),),
                    ),
                    const SizedBox(height: 12),
                    Text(noResults,style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        fontFamily: nunito
                    ),),
                    const SizedBox(height: 12),
                    Text('"${noResultsFor+ controller.ticketController.text.toString()}"\nor Symbol "${controller.symbolController.text.toString()}"',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: nunito
                    ),
                      textAlign: TextAlign.center,
                    ),

                  ],
                );
              } else {
                return ListView.builder(
                  controller: scrollingController.allHitsScrollController,
                  physics: const AlwaysScrollableScrollPhysics(
                      parent: BouncingScrollPhysics()),
                  itemCount: controller.searchHits.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (controller.dropping.value) {
                      if (controller.searchHits
                          .elementAt(index)
                          .pROFIT!
                          .isNegative) {
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
                                              tapBodyToCollapse: false,
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
                      } else {
                        return Container();
                      }
                    } else if (controller.rising.value) {
                      if (!controller.searchHits
                          .elementAt(index)
                          .pROFIT!
                          .isNegative) {
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
                                              tapBodyToCollapse: false,
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
                      } else {
                        return Container();
                      }
                    } else {
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
                                            tapBodyToCollapse: false,
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
                    }
                  },
                );
              }
            }),
          )
        ],
      ),
    ));
  }
}
