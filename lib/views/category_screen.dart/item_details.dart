import 'package:get/get.dart';

import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/consts/iconList.dart';
import 'package:whole_choice_customer/controller/product_controller.dart';

import 'package:flutter/material.dart';

import '../chat_screen/chat_screen.dart';

class ItemsDetailScreen extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemsDetailScreen({super.key, required this.title, this.data});

  @override
  Widget build(BuildContext context) {
    var contoller = Get.put(ProductController());

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
              title: title!.text.fontFamily(bold).color(darkFontGrey).make(),
              actions: [
                IconButton(
                    onPressed: () {},
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
                              width: double.infinity, fit: BoxFit.cover);
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
                        ).onTap(() {
                          Get.to(() => ChatScreen(),
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
                                        icon: const Icon(Icons.remove)),
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
                                        icon: const Icon(Icons.add)),
                                    10.heightBox,
                                    "${data['p_quantity']} avaiable"
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
                    ListView(
                      shrinkWrap: true,
                      children: List.generate(
                          itemDetailButtonList.length,
                          (index) => ListTile(
                                title: itemDetailButtonList[index]
                                    .text
                                    .fontFamily(semibold)
                                    .make(),
                                trailing: const Icon(Icons.arrow_forward),
                              )),
                    ),
                    10.heightBox,
                    productyoumaylike.text
                        .fontFamily(bold)
                        .color(darkFontGrey)
                        .make(),

                    // This is copied from feacture product Section
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(
                            6,
                            (index) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      imgP1,
                                      width: 160,
                                      fit: BoxFit.cover,
                                    ),
                                    10.heightBox,
                                    '''Hp EliteBook 840 G5
    8GB/256GB core i5
    8th gen'''
                                        .text
                                        .fontFamily(semibold)
                                        .color(darkFontGrey)
                                        .make(),
                                    10.heightBox,
                                    "\$600"
                                        .text
                                        .color(redColor)
                                        .fontFamily(bold)
                                        .make()
                                  ],
                                )
                                    .box
                                    .white
                                    .margin(const EdgeInsets.symmetric(
                                        horizontal: 4))
                                    .rounded
                                    .padding(const EdgeInsets.all(8))
                                    .make()),
                      ),
                    ),
                  ],
                )),
              )),
              SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: yellowColor),
                    onPressed: () {
                      if (contoller.quantity.value > 0) {
                        contoller.addToCart(
                            color: data['p_color'][contoller.colorIndex.value],
                            context: context,
                            vendorID: data['vendor_id'],
                            img: data['p_imgs'][0],
                            qty: contoller.quantity.value,
                            sellername: data['p_seller'],
                            title: data['p_name'],
                            tprice: contoller.totalPrice.value);
                        VxToast.show(context, msg: "Added to Cart");
                      } else {
                        VxToast.show(context,
                            msg: "Minimum 1 Product is requrired");
                      }
                    },
                    child: const Text(
                      "Add to Cart",
                      style: TextStyle(fontFamily: bold),
                    ),
                  ))
            ],
          )),
    );
  }
}
