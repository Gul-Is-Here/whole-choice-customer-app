import 'package:flutter/material.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/views/orders_screen/components/order_place_detail.dart';
import 'package:whole_choice_customer/views/orders_screen/components/order_status.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart' as intl;

class OrderDetailsScreen extends StatelessWidget {
  final dynamic data;
  const OrderDetailsScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: "Order Details".text.fontFamily(semibold).make(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              orderStatus(
                icon: Icons.done,
                color: redColor,
                title: "Inquiry Sent",
                showDone: data['order_placed'],
              ),
              orderStatus(
                  icon: Icons.thumb_up,
                  color: Colors.blue,
                  title: "Checked",
                  showDone: data['order_confirmed']),
              orderStatus(
                  icon: Icons.bus_alert,
                  color: yellowColor,
                  title: "Declined",
                  showDone: data['order_on_delivered']),
              orderStatus(
                  icon: Icons.done_all_rounded,
                  color: Colors.purple,
                  title: "Shipped",
                  showDone: data['order_delivered']),
              const Divider(),
              10.heightBox,
              Column(
                children: [
                  orderPlaceDetail(
                      d1: data['order_code'],
                      d2: data['shipping_method'],
                      title1: "Order Code",
                      title2: "Shipping Method"),
                  orderPlaceDetail(
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format((data['order_date'].toDate())),
                      d2: data['payment_method'],
                      title1: "Order Date",
                      title2: "Payment Method"),
                  orderPlaceDetail(
                      d1: "Unpiad",
                      d2: 'Order Placed',
                      title1: "Payment Status",
                      title2: "Delivery Status"),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 200,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Shipping Address"
                                  .text
                                  .fontFamily(semibold)
                                  .make(),
                              "${data['order_by_name']}".text.make(),
                              "${data['order_by_email']}".text.make(),
                              "${data['order_by_country']}".text.make(),
                              "${data['order_by_state']}".text.make(),
                              "${data['order_by_city']}".text.make(),
                              "${data['order_by_address']}".text.make(),
                              "${data['order_by_postalcode']}".text.make(),
                              "${data['order_by_phone']}".text.make(),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 80,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              "Total Amount".text.fontFamily(semibold).make(),
                              "${data['total_amount']}"
                                  .numCurrencyWithLocale()
                                  .text
                                  .color(redColor)
                                  .make(),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ).box.outerShadowMd.color(whiteColor).make(),
              const Divider(),
              10.heightBox,
              "Orders Products"
                  .text
                  .size(16)
                  .fontFamily(semibold)
                  .color(darkFontGrey)
                  .makeCentered(),
              10.heightBox,
              ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                children: List.generate(data['orders'].length, (index) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.heightBox,
                      // orderPlaceDetail(
                      //     title1: ,
                      //     title2: data['orders'][index]['tprice'],
                      //     d1: "${data['orders'][index]['qty']}x",
                      //     d2: "Refundable"),
                      "${data['orders'][index]['title']}"
                          .text
                          .fontFamily(bold)
                          .make(),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          "Amount".text.fontFamily(bold).make(),
                          "${data['orders'][index]['tprice']}"
                              .numCurrencyWithLocale()
                              .text
                              .make(),
                        ],
                      ),
                      10.heightBox,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          "Quantity".text.fontFamily(bold).make(),
                          "${data['orders'][index]['qty']}x"
                              .text
                              .fontFamily(bold)
                              .make(),
                        ],
                      ),
                      10.heightBox,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            "Color".text.fontFamily(bold).make(),
                            Container(
                              width: 30,
                              height: 20,
                              color: Color(data['orders'][index]['color']),
                            ),
                          ],
                        ),
                      ),
                      const Divider()
                    ],
                  );
                }).toList(),
              )
                  .box
                  .outerShadowMd
                  .color(whiteColor)
                  .margin(const EdgeInsets.only(bottom: 4))
                  .make(),
              20.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
