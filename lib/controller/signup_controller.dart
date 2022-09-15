import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:libphonenumber/libphonenumber.dart';
import 'package:sweet_snackbar/sweet_snackbar.dart';
import 'package:sweet_snackbar/top_snackbar.dart';
import 'package:uquitik_financials_task/constants/string_constants.dart';
import 'package:uquitik_financials_task/controller/splash_controller.dart';

import '../config/routing.dart';
import '../view/signup/info_signup.dart';
import '../view/trades/trades_screen.dart';

class SignupController extends GetxController {


  TextEditingController phoneController = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  GlobalKey<FormState> infoFormKey = GlobalKey();
  GlobalKey<FormState> phoneFormKey = GlobalKey();
  var loading = false.obs;

  bool obscure = true;


  @override
  void onClose() {
    phoneController.dispose();
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }



  void toggleObscure (){
    obscure = !obscure;
    update();
  }


  String? phoneValidator(String? value) {
    if (value!.isEmpty) {
      return enterPhone;
    } else {
      return null;
    }
  }

  String? nameValidator(String? value) {
    if (value!.isEmpty) {
      return enterName;
    } else {
      return null;
    }
  }

  String? emailValidator(String? value) {
    bool emailValid = RegExp(emailRegex).hasMatch(value.toString());

    if (value!.isEmpty ) {
      return enterEmail;
    } else if (!emailValid || (value.toString().trim().contains(' '))) {
      return enterValidEmail;
    } else {
      return null;
    }
  }

  String? passwordValidator(String? value) {
    bool strongPassword = RegExp(passwordRegex).hasMatch(value.toString());
    if (value!.isEmpty) {
      return enterPassword;
    } else if (value.length < 7) {
      return enterStrongerPassword;
    } else if (!strongPassword) {
      return enterValidPassword;
    } else {
      return null;
    }
  }

  String? confirmPasswordValidator(String? value) {
    if (value!.isEmpty) {
      return enterConfirmPassword;
    } else if (passwordController.text != confirmPasswordController.text) {
      return confirmPassword;
    } else {
      return null;
    }
  }

  void signup() async {
    if (infoFormKey.currentState!.validate()) {
      loading.value = true;
      update();
      await Future.delayed(const Duration(seconds: 2));
      loading.value = false;
      update();
      Get.offAll(()=>TradingScreen());
    }
  }

  void validatePhone(context) async {
    SplashController splashController = Get.find();
    if (phoneFormKey.currentState!.validate()) {
      bool? isValid = await PhoneNumberUtil.isValidPhoneNumber(
          phoneNumber: phoneController.text.toString(),
          isoCode: splashController.userData.countryCode.toString());
      if (phoneController.text.toString().contains(RegExp(phoneRegex))) {
        showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: enterValidSnackBarHint,
            ));
      } else if (isValid!) {
        Navigator.of(context)
            .push(CustomRouting().createRoute(InfoSignUpScreen()));
      } else {
        showTopSnackBar(
            context,
            CustomSnackBar.error(
              message: enterValidSnackBarHint,
            ));
      }
    }
  }
}
