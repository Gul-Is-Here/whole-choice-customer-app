import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/services/firestore_services.dart';
import 'package:whole_choice_customer/views/orders_screen/orders_details.dart';
import 'package:whole_choice_customer/widget_common/loading_indicator.dart';

class OrdersScreen extends StatelessWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: "My order".text.color(darkFontGrey).fontFamily(semibold).make(),
      ),
      body: StreamBuilder(
        stream: FirestoreServies.getAllOrders(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: loadingIndicator(),
            );
          } else if (snapshot.data!.docs.isEmpty) {
            return " No Order Yet!".text.color(darkFontGrey).makeCentered();
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (BuildContext context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: '${index + 1}'
                          .text
                          .color(darkFontGrey)
                          .size(20)
                          .make(),
                      title: data[index]['order_code']
                          .toString()
                          .text
                          .color(yellowColor)
                          .fontFamily(semibold)
                          .make(),
                      subtitle: data[index]['total_amount']
                          .toString()
                          .numCurrencyWithLocale()
                          .text
                          .fontFamily(bold)
                          .make(),
                      trailing: IconButton(
                        onPressed: () {
                          Get.to(() => OrderDetailsScreen(
                                data: data[index],
                              ));
                        },
                        icon: const Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: darkFontGrey,
                        ),
                      ),
                    ),
                  );
                });
          }
        },
      ),
    );
  }
}
