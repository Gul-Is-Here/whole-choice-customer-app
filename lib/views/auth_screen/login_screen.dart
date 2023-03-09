import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/consts/iconList.dart';
import 'package:whole_choice_customer/controller/auth_controller.dart';
import 'package:whole_choice_customer/views/auth_screen/forget_password_screen.dart';
import 'package:whole_choice_customer/views/auth_screen/login_number_screen.dart';
import 'package:whole_choice_customer/widget_common/custom_textfield.dart';
import 'package:whole_choice_customer/widget_common/our_button.dart';
import 'package:get/get.dart';

import '../home-screens/home.dart';
import '/widget_common/applogo_widget.dart';
import '/widget_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'signup_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
      child: Scaffold(
        backgroundColor: yellowColor,
        resizeToAvoidBottomInset: false,
        body: Center(
          child: Column(
            children: [
              (context.screenHeight * 0.1).heightBox,
              applogoWidget(),
              10.heightBox,
              "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
              15.heightBox,
              Obx(
                () => Column(
                  children: [
                    customTextField(
                        controller: controller.emailController,
                        hint: emailHint,
                        title: email,
                        icon: emailIcon,
                        isPass: false),
                    5.heightBox,
                    customTextField(
                        controller: controller.passwordController,
                        hint: passwordHint,
                        title: password,
                        icon: passwordIcon,
                        isPass: false),
                    Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: () {
                              Get.to(() => const ForgetPasswordScreen());
                            },
                            child: forgetPass.text.make())),
                    // --------------------> Login Button Scetion <------------------------
                    controller.isLoading.value
                        ? const CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(yellowColor),
                          )
                        : ourButton(
                            Color: yellowColor,
                            title: login,
                            textColor: whiteColor,
                            onpress: () async {
                              controller.isLoading(true);
                              await controller
                                  .loginMethod(context: context)
                                  .then((value) {
                                if (value != null) {
                                  VxToast.show(context, msg: loggedin);
                                  Get.offAll(() => const Home());
                                } else {
                                  controller.isLoading(false);
                                }
                              });
                            }).box.width(context.screenWidth - 50).make(),
                    10.heightBox, createNewAccount.text.color(fontGrey).make(),
                    10.heightBox,
                    //  -----------------> Signup Button Section <--------------------

                    ourButton(
                        Color: Colors.black26,
                        title: signup,
                        textColor: whiteColor,
                        onpress: () {
                          Get.to(() => const Signup());
                        }).box.width(context.screenWidth - 50).make(),
                    5.heightBox,
                    loginwith.text.color(fontGrey).make(), 5.heightBox,

                    //  --------------------> Icons addtion Section <--------------
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: List.generate(
                    //       3,
                    //       (index) => Padding(
                    //             padding: const EdgeInsets.all(8.0),
                    //             child: CircleAvatar(
                    //               backgroundColor: lightGrey,
                    //               radius: 25,
                    //               child: Image.asset(
                    //                 socialIconList[index],
                    //                 width: 30,
                    //               ),
                    //             ),
                    //           )),
                    // )
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleAvatar(
                          backgroundColor: lightGrey,
                          radius: 25,
                          child: IconButton(
                              onPressed: () {
                                Get.to(() => PhoneLoginScreen());
                              },
                              icon: const Icon(
                                Icons.phone,
                                color: yellowColor,
                              )),
                        )
                      ],
                    )
                  ],
                )
                    .box
                    .color(whiteColor)
                    .rounded
                    .padding(const EdgeInsets.all(16))
                    .width(context.screenWidth - 70)
                    .shadowSm
                    .make(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
