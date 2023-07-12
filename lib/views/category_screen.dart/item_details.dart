import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whatsapp_share/whatsapp_share.dart';

import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/consts/iconList.dart';
import 'package:whole_choice_customer/controller/auth_controller.dart';
import 'package:whole_choice_customer/controller/product_controller.dart';

import 'package:flutter/material.dart';
import 'package:whole_choice_customer/views/Profile_screen/privacy_policy_screen.dart';
import 'package:whole_choice_customer/views/Profile_screen/return_policy_screen.dart';
import 'package:whole_choice_customer/views/category_screen.dart/review_screen.dart';

import '../../services/firestore_services.dart';
import '../../widget_common/loading_indicator.dart';
import '../chat_screen/chat_screen.dart';

class ItemsDetailScreen extends StatelessWidget {
  final String? title;

  final dynamic data;
  const ItemsDetailScreen({
    super.key,
    required this.title,
    this.data,
  });

  @override
  Widget build(BuildContext context) {
    var contoller = Get.put(ProductController());
    // var pController = Get.find<AuthController>();
    Future<void> share() async {
      await WhatsappShare.share(
        text: 'Whatsapp share text',
        linkUrl: 'https://wa.me/',
        phone: '911234567890',
      );
    }

    return WillPopScope(
      onWillPop: () async {
        contoller.resetValues();
        return true;
      },
      child: Scaffold(
          backgroundColor: whiteColor,
          appBar: AppBar(
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: darkFontGrey,
                ),
                onPressed: () {
                  contoller.resetValues();
                  Get.back();
                },
              ),
              elevation: 0,
              backgroundColor: whiteColor,
              // title: title!.text.fontFamily(bold).color(darkFontGrey).make(),
              actions: [
                IconButton(
                    onPressed: share,
                    icon: const Icon(
                      Icons.share,
                      color: darkFontGrey,
                    )),
                Obx(
                  () => IconButton(
                      onPressed: () {
                        if (contoller.isFav.value) {
                          contoller.removeFromWishlst(data.id, context);
                          contoller.isFav(false);
                        } else {
                          contoller.addToWishlst(data.id, context);
                          contoller.isFav(true);
                        }
                      },
                      icon: Icon(
                        Icons.favorite_outlined,
                        color:
                            contoller.isFav.value ? yellowColor : darkFontGrey,
                      )),
                )
              ]),
          body: Column(
            children: [
              Expanded(
                  child: Padding(
                padding: const EdgeInsets.all(8),
                child: SingleChildScrollView(
                    child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VxSwiper.builder(
                        autoPlay: true,
                        height: 350,
                        aspectRatio: 16 / 9,
                        viewportFraction: 1.0,
                        itemCount: data['p_imgs'].length,
                        itemBuilder: (context, index) {
                          return Image.network(data['p_imgs'][index],
                              width: double.infinity, fit: BoxFit.fitHeight);
                        }),

                    // -------> Tittle and Details Section
                    10.heightBox,
                    "${data['p_desc']}"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    VxRating(
                      isSelectable: false,
                      value: double.parse(data['p_rating']),
                      onRatingUpdate: (value) {},
                      normalColor: textfieldGrey,
                      selectionColor: golden,
                      count: 5,
                      size: 25,
                      maxRating: 5,
                    ),
                    10.heightBox,
                    "${data['p_price']}"
                        .numCurrencyWithLocale()
                        .text
                        .color(redColor)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    Row(
                      children: [
                        Expanded(
                            child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            "Seller".text.white.make(),
                            5.heightBox,
                            "${data['p_seller']}"
                                .text
                                .fontFamily(semibold)
                                .color(darkFontGrey)
                                .size(16)
                                .make()
                          ],
                        )),
                        const CircleAvatar(
                          backgroundColor: whiteColor,
                          child: Icon(
                            Icons.message,
                            color: darkFontGrey,
                          ),
                        ).onTap(() async {
                          Get.to(
                              () => ChatScreen(
                                    sellerName: "${data['p_seller']}",
                                    sellerEmail: "${data['p_seller']}",
                                    // sellerNumber: "${data['p_seller']}",
                                  ),
                              arguments: [data['p_seller'], data['vendor_id']]);
                        })
                      ],
                    )
                        .box
                        .height(60)
                        .padding(const EdgeInsets.symmetric(horizontal: 16))
                        .color(textfieldGrey)
                        .make(),
                    20.heightBox,
                    Obx(
                      () => Column(
                        children: [
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: 'Color'
                                    .text
                                    .white
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Row(
                                children: List.generate(
                                    data['p_color'].length,
                                    (index) => Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .size(40, 40)
                                                .roundedFull
                                                .color(Color(
                                                        data['p_color'][index])
                                                    .withOpacity(1.0))
                                                .margin(
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 6))
                                                .make()
                                                .onTap(
                                              () {
                                                contoller
                                                    .changeColorIndex(index);
                                              },
                                            ),
                                            Visibility(
                                                visible: index ==
                                                    contoller.colorIndex.value,
                                                child: const Icon(
                                                  Icons.done,
                                                  color: Colors.white,
                                                ))
                                          ],
                                        )),
                              )
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          //----->  Quantity Row <-------
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: 'Quantity'
                                    .text
                                    .white
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Obx(
                                () => Row(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        contoller.decreaseQuantity();
                                        contoller.calculateTotalPrice(
                                            double.parse(data['p_price'])
                                                .toInt());
                                      },
                                      icon: const Icon(Icons.remove),
                                    ),
                                    contoller.quantity.value.text
                                        .size(16)
                                        .color(darkFontGrey)
                                        .make(),
                                    IconButton(
                                      onPressed: () {
                                        contoller.increaseQuantity(
                                            int.parse(data['p_quantity']));
                                        contoller.calculateTotalPrice(
                                            double.parse(data['p_price'])
                                                .toInt());
                                      },
                                      icon: const Icon(Icons.add),
                                    ),
                                    10.heightBox,
                                    if (contoller.quantity.value >
                                        int.parse(data['p_quantity']))
                                      "Out of Stock"
                                          .text
                                          .color(Colors.red)
                                          .make()
                                    else
                                      "${data['p_quantity']} available"
                                          .text
                                          .color(textfieldGrey)
                                          .make(),
                                  ],
                                ),
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make(),

                          // total Row
                          Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: 'Total'
                                    .text
                                    .white
                                    .color(textfieldGrey)
                                    .make(),
                              ),
                              Row(
                                children: [
                                  "${contoller.totalPrice.value}"
                                      .numCurrencyWithLocale()
                                      .text
                                      .color(redColor)
                                      .size(16)
                                      .fontFamily(bold)
                                      .make()
                                ],
                              ),
                            ],
                          ).box.padding(const EdgeInsets.all(8)).make()
                        ],
                      ).box.white.shadowSm.make(),
                    ),
                    // discription
                    10.heightBox,

                    "Discription"
                        .text
                        .color(darkFontGrey)
                        .fontFamily(semibold)
                        .make(),
                    10.heightBox,
                    "${data['p_desc']}".text.color(darkFontGrey).make(),

                    // ----> Bttons Section
// ----> Bttons Section
                    ListView(
                      shrinkWrap: true,
                      children: List.generate(
                        itemDetailButtonList.length,
                        (index) => ListTile(
                          onTap: () {
                            switch (index) {
                              case 0:
                                Get.to(() => const ReviewScreen());
                                break;
                              case 1:
                                Get.to(() => PrivacyPolicyScreen());
                                break;
                              case 2:
                                Get.to(() => ReturnPolicyScreen());
                                break;
                            }
                          },
                          title: itemDetailButtonList[index]
                              .text
                              .fontFamily(semibold)
                              .make(),
                          trailing: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ),
                    10.heightBox,
                    productyoumaylike.text
                        .fontFamily(bold)
                        .color(darkFontGrey)
                        .make(),

// This is copied from feacture product Section
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: StreamBuilder(
                        stream: FirestoreServies.getFeaturedProduct(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (!snapshot.hasData) {
                            return loadingIndicator();
                          } else if (snapshot.data!.docs.isEmpty) {
                            return "No Featured Product".text.makeCentered();
                          } else {
                            var featureData = snapshot.data!.docs;
                            return Row(
                              children: List.generate(
                                featureData.length,
                                (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                      featureData[index]['p_imgs'][0],
                                      width: MediaQuery.of(context).size.width *
                                          .4,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .2,
                                      fit: BoxFit.fitHeight,
                                    ),
                                    10.heightBox,
                                    SizedBox(
                                      width: 150,
                                      child: Text(
                                        "${featureData[index]['p_name']}",
                                        overflow: TextOverflow
                                            .clip, // or TextOverflow.ellipsis
                                        style: const TextStyle(
                                          fontFamily: 'semibold',
                                          color: darkFontGrey,
                                        ),
                                      ),
                                    ),
                                    10.heightBox,
                                    "${featureData[index]['p_price']}"
                                        .numCurrencyWithLocale()
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .make(),
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .topRounded(value: 10.0)
                                    .padding(const EdgeInsets.all(4))
                                    .clip(Clip.antiAlias)
                                    .make()
                                    .onTap(() {
                                  ItemsDetailScreen(
                                      title: "${featureData[index]['p_name']}",
                                      data: featureData[index]);
                                }),
                              ),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                )),
              )),
              SizedBox(
                width: double.infinity,
                height: 60,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: yellowColor),
                  onPressed: () {
                    if (contoller.quantity.value > 50) {
                      if (contoller.quantity.value <= 200) {
                        // Check if quantity is less than or equal to 10
                        contoller.addToCart(
                          color: data['p_color'][contoller.colorIndex.value],
                          context: context,
                          vendorID: data['vendor_id'],
                          img: data['p_imgs'][0],
                          qty: contoller.quantity.value,
                          sellername: data['p_seller'],
                          title: data['p_name'],
                          tprice: contoller.totalPrice.value.toDouble(),
                        );
                        VxToast.show(context, msg: "Added to Cart");
                      } else {
                        VxToast.show(context,
                            msg:
                                "Maximum 200 products can be added to the cart");
                      }
                    } else {
                      VxToast.show(context,
                          msg: "Minimum 50 Product is required");
                    }
                  },
                  child: "Add to Cart".text.fontFamily(bold).make(),
                ).box.roundedSM.padding(const EdgeInsets.all(8)).make(),
              ),
            ],
          )),
    );
  }
}
