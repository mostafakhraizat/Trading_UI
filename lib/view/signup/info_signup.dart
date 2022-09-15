import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:sweet_snackbar/sweet_snackbar.dart';
import 'package:sweet_snackbar/top_snackbar.dart';
import 'package:uquitik_financials_task/constants/asset_api_paths.dart';
import 'package:uquitik_financials_task/constants/string_constants.dart';
import 'package:uquitik_financials_task/controller/signup_controller.dart';
import '../../constants/style_constants.dart';
import '../../controller/network_controller.dart';

class InfoSignUpScreen extends StatelessWidget {
   InfoSignUpScreen({Key? key}) : super(key: key);
   final SignupController signUpController = Get.find();
   final NetworkController networkController = Get.find();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
        appBar: null,
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
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
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          style: bodyTextBoldBlack,
                          children: <TextSpan>[
                            TextSpan(text: oneStep, style: bodyTextBoldBlack),
                            TextSpan(text: " $go", style: bodyTextBoldBlue.copyWith(
                              color: Colors.blue[800]
                            )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        fillForm,
                        style: bodyTextNormal,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  GetBuilder<SignupController>(
                    builder: (controller) {
                      return Form(
                          key: signUpController.infoFormKey,
                          child: Column(
                            children: [
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: signUpController.fullNameController,
                                onChanged: (value) {},
                                validator: signUpController.nameValidator,
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide()),
                                  prefixIcon: const Icon(IconlyBold.profile),
                                  hintText: fullNameHint,
                                  hintStyle: bodyTextNormal,
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: signUpController.emailController,
                                onChanged: (value) {},
                                validator: signUpController.emailValidator,
                                keyboardType: TextInputType.emailAddress,
                                autofocus: false,
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide()),
                                  prefixIcon: const Icon(IconlyBold.message),
                                  hintText: emailAddressHint,
                                  hintStyle: bodyTextNormal,
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.next,
                                controller: signUpController.passwordController,
                                onChanged: (value) {},
                                validator: signUpController.passwordValidator,
                                keyboardType: TextInputType.text,
                                autofocus: false,
                                obscureText: signUpController.obscure,

                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      signUpController.toggleObscure();
                                    },
                                    child: signUpController.obscure?Icon(CupertinoIcons.eye_slash_fill):Icon(CupertinoIcons.eye),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide()),
                                  prefixIcon: const Icon(IconlyBold.lock),
                                  hintText: passwordHint,
                                  hintStyle: bodyTextNormal,
                                ),
                              ),
                              const SizedBox(
                                height: 14,
                              ),
                              TextFormField(
                                textInputAction: TextInputAction.done,
                                controller:
                                    signUpController.confirmPasswordController,
                                onChanged: (value) {},
                                validator:
                                    signUpController.confirmPasswordValidator,
                                keyboardType: TextInputType.text,
                                obscureText: signUpController.obscure,
                                autofocus: false,
                                decoration: InputDecoration(
                                  suffixIcon: InkWell(
                                    onTap: (){
                                      signUpController.toggleObscure();
                                    },
                                    child: signUpController.obscure?Icon(CupertinoIcons.eye_slash_fill):Icon(CupertinoIcons.eye),
                                  ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      borderSide: const BorderSide()),
                                  prefixIcon: const Icon(IconlyBold.lock),
                                  hintText: confirmPasswordHint,
                                  hintStyle: bodyTextNormal,
                                ),
                              ),
                              const SizedBox(
                                height: 42,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GetBuilder<SignupController>(
                                      builder: (controller) {
                                    if (controller.loading.value) {
                                      return Container(
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(12),
                                          color: Colors.grey[100],
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 40),
                                          child: Row(
                                            children:  [
                                              Text(creating,style: const TextStyle(
                                                color: Colors.black
                                              ),),
                                              const CircularProgressIndicator(
                                                color: Colors.grey,
                                                backgroundColor: Colors.black,
                                                strokeWidth: 1,
                                              ),
                                            ],
                                          ),
                                        ),
                                      );
                                    } else {

                                      return InkWell(
                                        onTap:(){
                                          if (networkController.connectionType.value == 0) {
                                            showTopSnackBar(context, CustomSnackBar.info(message: noInternet));
                                          }else{
                                            signUpController.signup();
                                          }
                                        } ,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: Colors.blue[800]!,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 10, horizontal: 30),
                                            child: Text(
                                              register,
                                            ),
                                          ),
                                        ),
                                      );
                                    }
                                  })
                                ],
                              ),
                            ],
                          ));
                    }
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
