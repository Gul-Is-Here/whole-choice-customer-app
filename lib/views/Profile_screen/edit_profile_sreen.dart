import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/controller/profile_controller.dart';
import 'package:whole_choice_customer/widget_common/bg_widget.dart';
import 'package:whole_choice_customer/widget_common/custom_textfield.dart';
import 'package:whole_choice_customer/widget_common/our_button.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    var contoller = Get.find<ProfileController>();

    return bgWidget(
      child: Container(
        color: redColor,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            // toolbarHeight: 100,
            elevation: 0,
            title: const Text(
              'Edit Profile',
              style: TextStyle(fontFamily: bold),
            ),
            centerTitle: true,
            // backgroundColor: Colors.transparent,
          ),
          body: SingleChildScrollView(
            child: Obx(
              () => Column(
                // mainAxisSize: MainAxisSize.min,
                children: [
                  data['imageUrl'] == '' && contoller.profileImgPath.isEmpty
                      ? Image.asset(
                          imgProfileFaraz,
                          width: 200,
                          fit: BoxFit.cover,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : data['imageUrl'] != '' &&
                              contoller.profileImgPath.isEmpty
                          ? Image.network(data['imageUrl'],
                                  width: 200, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make()
                          : Image.file(File(contoller.profileImgPath.value),
                                  width: 100, fit: BoxFit.cover)
                              .box
                              .roundedFull
                              .clip(Clip.antiAlias)
                              .make(),
                  10.heightBox,
                  ourButton(
                      Color: yellowColor,
                      onpress: () {
                        contoller.changeImage(context);
                      },
                      textColor: whiteColor,
                      title: "Change image"),
                  const Divider(
                    thickness: 2,
                  ),
                  customTextField(
                      controller: contoller.nameController,
                      hint: hintName,
                      title: name,
                      icon: nameIcon,
                      isPass: false),
                  10.heightBox,
                  customTextField(
                      controller: contoller.oldpassController,
                      hint: passwordHint,
                      title: oldpass,
                      icon: passwordIcon,
                      isPass: true),
                  10.heightBox,
                  customTextField(
                      controller: contoller.newpassController,
                      hint: passwordHint,
                      title: newpass,
                      icon: passwordIcon,
                      isPass: true),
                  20.heightBox,
                  contoller.isLoading.value
                      ? const CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(yellowColor),
                        )
                      : SizedBox(
                          width: context.screenWidth - 40,
                          child: ourButton(
                              Color: yellowColor,
                              onpress: () async {
                                contoller.isLoading(true);

                                //if image is not selected
                                if (contoller.profileImgPath.value.isNotEmpty) {
                                  await contoller.uploadProfileImage();
                                } else {
                                  contoller.profileImageLink = data['imageUrl'];
                                }
                                // if old password matche database
                                if (data['password'] ==
                                    contoller.oldpassController.text) {
                                  await contoller.changeAuthPassword(
                                      email: data['email'],
                                      password:
                                          contoller.oldpassController.text,
                                      newpassword:
                                          contoller.newpassController.text);
                                  await contoller.updateProfile(
                                      imgUrl: contoller.profileImageLink,
                                      name: contoller.nameController.text,
                                      password:
                                          contoller.newpassController.text);
                                  VxToast.show(context, msg: "updated");
                                } else {
                                  VxToast.show(context,
                                      msg: "Enter Correct Old Password");
                                  contoller.isLoading(false);
                                }
                              },
                              textColor: whiteColor,
                              title: "Save"),
                        ),
                ],
              )
                  .box
                  .white
                  .shadowSm
                  .roundedSM
                  .padding(EdgeInsets.all(16))
                  // .margin(EdgeInsets.only(top: 60, left: 12, right: 12, bottom: 60))
                  .make(),
            ),
          ),
        ),
      ),
    );
  }
}
