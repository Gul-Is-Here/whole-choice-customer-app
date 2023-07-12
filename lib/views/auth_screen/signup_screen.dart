import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/controller/auth_controller.dart';
import 'package:whole_choice_customer/views/auth_screen/login_screen.dart';

import '../../consts/consts.dart';
import '../../widget_common/applogo_widget.dart';
import '../../widget_common/bg_widget.dart';
import '../../widget_common/custom_textfield.dart';
import '../../widget_common/our_button.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  bool? isCheck = false;
  var controller = Get.put(AuthController());

  //controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phone = TextEditingController();
  @override
  Widget build(BuildContext context) {
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
            "Register in $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Expanded(
              child: SingleChildScrollView(
                child: Obx(
                  () => Column(
                    children: [
                      customTextField(
                          validate: (value) {
                            if (value.length < 3 || value.isEmpty) {
                              const Text(
                                'name length 3 character',
                                style: TextStyle(color: redColor),
                              );
                            }
                          },
                          hint: hintName,
                          title: name,
                          icon: nameIcon,
                          controller: nameController,
                          isPass: false),
                      5.heightBox,
                      customTextField(
                          validate: (value) {
                            if (value.isEmpty || value.length < 11) {
                              const Text(
                                'Enter valid phone number',
                                style: TextStyle(color: redColor),
                              );
                            }
                          },
                          hint: emailHint,
                          title: email,
                          icon: emailIcon,
                          controller: emailController,
                          isPass: false),
                      5.heightBox,
                      customTextField(
                          validate: (value) {
                            if (value.isEmpty || value.length < 11) {
                              const Text(
                                'Enter valid phone number',
                                style: TextStyle(color: redColor),
                              );
                            }
                          },
                          hint: passwordHint,
                          title: password,
                          icon: passwordIcon,
                          controller: passwordController,
                          isPass: true),
                      5.heightBox,
                      customTextField(
                          validate: (value) {
                            if (value.isEmpty || value.length < 11) {
                              const Text(
                                'Enter valid phone number',
                                style: TextStyle(color: redColor),
                              );
                            }
                          },
                          hint: '+16318269672',
                          title: 'Phone',
                          icon: phoneIcon,
                          controller: phone,
                          isPass: true),
                      // Align(
                      //     alignment: Alignment.centerRight,
                      //     child: TextButton(
                      //         onPressed: () {}, child: forgetPass.text.make())),
                      5.heightBox,

                      Row(
                        children: [
                          Checkbox(
                              checkColor: whiteColor,
                              activeColor: redColor,
                              value: isCheck,
                              onChanged: (newValue) {
                                setState(() {
                                  isCheck = newValue;
                                });
                              }),
                          10.widthBox,
                          Expanded(
                            child: RichText(
                              text: const TextSpan(children: [
                                TextSpan(
                                    text: 'I agree to the',
                                    style: TextStyle(
                                        fontFamily: regular, color: fontGrey)),
                                TextSpan(
                                    text: termsCondition,
                                    style: TextStyle(
                                        fontFamily: regular, color: redColor)),
                                TextSpan(
                                    text: '&',
                                    style: TextStyle(
                                        fontFamily: regular, color: fontGrey)),
                                TextSpan(
                                    text: privacyPolicy,
                                    style: TextStyle(
                                        fontFamily: regular, color: redColor))
                              ]),
                            ),
                          )
                        ],
                      ),
                      5.heightBox,
                      controller.isLoading.value
                          ? const CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation(yellowColor),
                            )
                          :
                          // --------------------> Login Button Scetion <------------------------
                          ourButton(
                              Color: isCheck == true ? yellowColor : lightGrey,
                              title: signup,
                              textColor: whiteColor,
                              onpress: () async {
                                controller.isLoading(true);
                                if (isCheck != false) {
                                  try {
                                    await controller
                                        .signupMethod(
                                            context: context,
                                            email: emailController.text,
                                            password: passwordController.text)
                                        .then((value) {
                                      return controller.storeUserData(
                                          name: nameController.text,
                                          email: emailController.text,
                                          password: passwordController.text,
                                          phone: phone.text);
                                    }).then((value) {
                                      // VxToast.show(context, msg: loggedin);
                                      Get.off(() {
                                        controller.isLoading(false);
                                        const LoginScreen();
                                      });
                                    });
                                  } catch (e) {
                                    controller.isLoading(false);
                                    auth.signOut();
                                    VxToast.show(
                                      context,
                                      msg: validDetail,
                                    );
                                  }
                                }
                              }).box.width(context.screenWidth - 50).make(),
                      5.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          alreadyHaveAnAccount.text
                              .color(fontGrey)
                              .fontFamily(regular)
                              .make(),
                          login.text
                              .color(yellowColor)
                              .fontFamily(regular)
                              .make()
                              .onTap(() {
                            Get.back();
                          })
                        ],
                      )
                    ],
                  )
                      .box
                      .white
                      .rounded
                      .padding(const EdgeInsets.all(16))
                      .width(context.screenWidth - 70)
                      .shadowSm
                      .make(),
                ),
              ),
            )
          ],
        ),
      ),
    ));
  }
}
