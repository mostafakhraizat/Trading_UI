import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sweet_snackbar/sweet_snackbar.dart';
import 'package:sweet_snackbar/top_snackbar.dart';
import 'package:uquitik_financials_task/constants/asset_api_paths.dart';
import 'package:uquitik_financials_task/controller/network_controller.dart';
import 'package:uquitik_financials_task/controller/signup_controller.dart';
import 'package:uquitik_financials_task/controller/splash_controller.dart';
import '../../constants/string_constants.dart';
import '../../constants/style_constants.dart';



class PhoneSignupScreen extends StatelessWidget {
  PhoneSignupScreen({Key? key}) : super(key: key);
  final SplashController splashController = Get.find();
  final SignupController signUpController = Get.find();
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
                          offline,
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1!
                              .copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.red),
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
        appBar: null,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Hero(
                        tag: imageTag,
                        child: Image.asset(
                          equImage,
                          width: 200,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  Column(
                    children: [
                      Row(
                        children: [
                          Column(
                            children: [
                              RichText(
                                text: TextSpan(
                                  style: bodyTextBoldBlack,
                                  children: <TextSpan>[
                                    TextSpan(
                                        text: futureText,
                                        style: bodyTextBoldBlack),
                                    TextSpan(
                                        text: strategized,
                                        style: bodyTextBoldBlue),
                                    TextSpan(
                                        text: " $today", style: bodyTextBoldBlack),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            createNew,
                            style: bodyTextNormal,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 62,
                  ),
                  Column(
                    children: [
                      Form(
                          key: signUpController.phoneFormKey,
                          child: TextFormField(
                            textInputAction: TextInputAction.done,
                            controller: signUpController.phoneController,
                            onChanged: (value) {},
                            validator: signUpController.phoneValidator,
                            keyboardType: TextInputType.phone,
                            autofocus: false,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  borderSide: const BorderSide()),
                              prefixIcon: CountryCodePicker(
                                initialSelection:
                                    splashController.userData.countryCode,
                                showOnlyCountryWhenClosed: true,
                                alignLeft: false,
                                enabled: false,
                              ),
                              hintText: phoneHint,
                              hintStyle: bodyTextNormal,
                            ),
                          )),
                      const SizedBox(
                        height: 32,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          InkWell(
                            onTap: () {
                              if (networkController.connectionType.value == 0) {
                                showTopSnackBar(
                                    context,
                                    const CustomSnackBar.info(
                                        message: 'No internet access'));
                              } else {
                                signUpController.validatePhone(context);
                              }
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.blue[800]!,
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 30),
                                child: Text(
                                  next,
                                  style: buttonText,
                                ),
                              ),
                            ),
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
