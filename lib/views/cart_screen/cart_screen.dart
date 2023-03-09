import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:whole_choice_customer/controller/cart_controller.dart';
import 'package:whole_choice_customer/services/firestore_services.dart';
import 'package:whole_choice_customer/views/cart_screen/shipping_screen.dart';
import 'package:whole_choice_customer/widget_common/loading_indicator.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var contoller = Get.put(CartController());

    return Scaffold(
        bottomNavigationBar: SizedBox(
          height: 60,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: yellowColor),
              onPressed: () {
                Get.to(() => const ShippinDetails());
              },
              child: "Proceed to shipping"
                  .text
                  .fontFamily(semibold)
                  .size(16)
                  .make()),
        ),
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: "Shopping cart"
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .make()),
        body: StreamBuilder(
            stream: FirestoreServies.getCart(currentUser!.uid),
            builder:
                (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: loadingIndicator(),
                );
              } else if (snapshot.data!.docs.isEmpty) {
                return Center(
                  child: "Cart is Empty".text.color(darkFontGrey).make(),
                );
              } else {
                var data = snapshot.data!.docs;
                contoller.calculate(data);
                contoller.productSnapshot = data;
                return Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SizedBox(
                                height: 80,
                                child: Card(
                                  child: ListTile(
                                    leading: Image.network(
                                      "${data[index]['img']}",
                                      width: 120,
                                      fit: BoxFit.cover,
                                    ),
                                    title:
                                        "${data[index]['title']}  (  ${data[index]['qty']})"
                                            .text
                                            .fontFamily(semibold)
                                            .size(16)
                                            .color(darkFontGrey)
                                            .make(),
                                    subtitle: "${data[index]['tprice']}"
                                        .numCurrencyWithLocale()
                                        .text
                                        .size(14)
                                        .color(redColor)
                                        .fontFamily(semibold)
                                        .make(),
                                    trailing: const Icon(
                                      Icons.delete,
                                      color: redColor,
                                    ).onTap(() {
                                      FirestoreServies.deleteDocument(
                                          data[index].id);
                                    }),
                                  ),
                                ),
                              );
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          "Total price"
                              .text
                              .color(darkFontGrey)
                              .fontFamily(semibold)
                              .make(),
                          Obx(
                            () => "${contoller.totalP.value}"
                                .numCurrencyWithLocale()
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make(),
                          ),
                        ],
                      )
                          .box
                          .padding(EdgeInsets.all(12))
                          .color(yellowColor)
                          .roundedSM
                          .width(context.screenWidth - 60)
                          .make(),
                      10.heightBox,
                    ],
                  ),
                );
              }
            }));
  }
}
