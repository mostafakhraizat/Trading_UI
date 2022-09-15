import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:uquitik_financials_task/controller/network_controller.dart';
import 'package:uquitik_financials_task/controller/splash_controller.dart';

import '../../constants/asset_api_paths.dart';
import '../../constants/string_constants.dart';

class SplashScreen extends StatelessWidget {
  SplashScreen({Key? key}) : super(key: key);
  final SplashController splashController = Get.find();
  final NetworkController networkController = Get.find();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                          "You're offline",
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

        appBar: AppBar(
          toolbarHeight: 0,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GetBuilder(
                  init: splashController,
                  initState: (controller) async {
                    splashController.printIps(context);
                  },
                  builder: (spController) {
                    return Column(
                      children: [
                        Hero(
                          tag: imageTag,
                          child: Image.asset(
                            equImage,
                            width: 200,
                          ),
                        ),
                        const SizedBox(
                          height: 22,
                        ),
                        GetBuilder<NetworkController>(
                            init: networkController,
                            builder: (controller) {
                              if((networkController.connectionType.value==1 || networkController.connectionType.value==2) ){
                                return CircularProgressIndicator(
                                  strokeWidth: 1,
                                  backgroundColor: Colors.grey[400],
                                  color: Colors.grey[600],
                                );
                              }else{
                                return Text('No internet connection',style: Theme.of(context).textTheme.bodyText1!.copyWith(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16
                                ),);
                              }

                          }
                        ),
                        const SizedBox(height: 12,)
                      ],
                    );
                  }),
            ],
          ),
        ));
  }
}
