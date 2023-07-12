import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:flutter/material.dart';
import 'package:whole_choice_customer/controller/cart_controller.dart';
import 'package:whole_choice_customer/services/firestore_services.dart';
import 'package:whole_choice_customer/views/cart_screen/shipping_screen.dart';
import 'package:whole_choice_customer/widget_common/loading_indicator.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: "Shopping cart"
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServies.getCart(currentUser!.uid),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            controller.calculate(data);
            controller.productSnapshot = data;
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
                                  "${data[index]['title']}  (${data[index]['qty']})"
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
                              trailing: GestureDetector(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: Text('Delete Item'),
                                        content: Text(
                                            'Are you sure you want to delete this item from your cart?'),
                                        actions: [
                                          TextButton(
                                            child: Text(
                                              'No',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                          ),
                                          TextButton(
                                            child: Text(
                                              'Yes',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Theme.of(context)
                                                      .primaryColor),
                                            ),
                                            onPressed: () {
                                              FirestoreServies.deleteDocument(
                                                  data[index]
                                                      .id); // Delete the item
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                child: const Icon(
                                  Icons.delete,
                                  color: redColor,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
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
                        () => "${controller.totalP.value}"
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
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: yellowColor,
                      ),
                      onPressed: () {
                        if (snapshot.hasData &&
                            snapshot.data!.docs.isNotEmpty) {
                          Get.to(() => ShippinDetails());
                        }
                      },
                      child: const Text('Proceed To Shipping'),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
