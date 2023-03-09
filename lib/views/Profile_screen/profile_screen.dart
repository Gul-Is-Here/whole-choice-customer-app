import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/consts/iconList.dart';
import 'package:whole_choice_customer/controller/auth_controller.dart';
import 'package:whole_choice_customer/controller/profile_controller.dart';
import 'package:whole_choice_customer/services/firestore_services.dart';
import 'package:whole_choice_customer/views/Profile_screen/components/details_card.dart';
import 'package:whole_choice_customer/views/chat_screen/messagng_screen.dart';
import 'package:whole_choice_customer/views/orders_screen/order_screen.dart';
import 'package:whole_choice_customer/views/wishlist_screen/wishlist_screen.dart';
import 'package:whole_choice_customer/widget_common/bg_widget.dart';
import 'package:flutter/material.dart';
import 'package:whole_choice_customer/widget_common/loading_indicator.dart';

import '../auth_screen/login_screen.dart';
import 'edit_profile_sreen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var contoller = Get.put(ProfileController());

    return bgWidget(
      child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            elevation: 0,
            title: const Text(
              "Profile",
              style: TextStyle(fontFamily: bold),
            ),
            centerTitle: false,
          ),
          body: StreamBuilder(
            stream: FirestoreServies.getUser(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(yellowColor)),
                );
              } else {
                var data = snapshot.data!.docs[0];
                return SafeArea(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            data['imageUrl'] == ''
                                ? Image.asset(
                                    imgProfileFaraz,
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make()
                                : Image.network(
                                    data['imageUrl'],
                                    width: 100,
                                    fit: BoxFit.cover,
                                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                            10.widthBox,
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  "${data['email']}"
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                  const Icon(Icons.edit).onTap(() {
                                    Get.to(() => EditProfileScreen(
                                          data: data,
                                        ));
                                  })
                                ],
                              ),
                            ),
                            OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: yellowColor)),
                              onPressed: () async {
                                await Get.put(AuthController())
                                    .signoutMethod(context);
                                Get.offAll(() => const LoginScreen());
                              },
                              child: logout.text
                                  .fontFamily(semibold)
                                  .color(fontGrey)
                                  .make(),
                            )
                          ],
                        ),
                      ),
                      const Divider(),
                      FutureBuilder(
                        future: FirestoreServies.getCounts(),
                        builder:
                            (BuildContext context, AsyncSnapshot snapshot) {
                          if (!snapshot.hasData) {
                            return loadingIndicator();
                          } else {
                            var countData = snapshot.data;
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                10.heightBox,
                                detailsCard(
                                    count: countData[0].toString(),
                                    title: "in your cart",
                                    width: context.screenWidth / 4),
                                detailsCard(
                                    count: countData[1].toString(),
                                    title: "in your wishlist",
                                    width: context.screenWidth / 4),
                                detailsCard(
                                    count: countData[2].toString(),
                                    title: "your orders",
                                    width: context.screenWidth / 4)
                              ],
                            );
                          }
                        },
                      ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [
                      //     10.heightBox,
                      //     detailsCard(
                      //         count: data['cart_count'],
                      //         title: "in your cart",
                      //         width: context.screenWidth / 4),
                      //     detailsCard(
                      //         count: data['wishlist_count'],
                      //         title: "in your wishlist",
                      //         width: context.screenWidth / 4),
                      //     detailsCard(
                      //         count: data['order_count'],
                      //         title: "your orders",
                      //         width: context.screenWidth / 4)
                      //   ],
                      // ),
                      5.heightBox,
                      ListView.separated(
                              shrinkWrap: true,
                              separatorBuilder: (context, index) {
                                return const Divider(
                                  color: lightGrey,
                                );
                              },
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  onTap: () {
                                    switch (index) {
                                      case 0:
                                        Get.to(() => const OrdersScreen());

                                        break;
                                      case 1:
                                        Get.to(() => const WishlistScreen());
                                        break;
                                      case 2:
                                        Get.to(() => const MessagesScreen());
                                        break;
                                    }
                                  },
                                  leading: Image.asset(
                                    profileIconList[index],
                                    width: 22,
                                  ),
                                  title: profieButtonList[index]
                                      .text
                                      .fontFamily(semibold)
                                      .color(darkFontGrey)
                                      .make(),
                                );
                              },
                              itemCount: profieButtonList.length)
                          .box
                          .white
                          .rounded
                          .shadowSm
                          .margin(const EdgeInsets.all(12))
                          .padding(const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16))
                          .make()
                          .box
                          .color(whiteColor)
                          .make()
                    ],
                  ),
                );
              }
            },
          )),
    );
  }
}
