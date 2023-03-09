import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/consts/consts.dart';
import 'package:whole_choice_customer/consts/iconList.dart';
import 'package:whole_choice_customer/controller/cart_controller.dart';
import 'package:whole_choice_customer/views/home-screens/home.dart';
import 'package:whole_choice_customer/widget_common/loading_indicator.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({super.key});

  @override
  Widget build(BuildContext context) {
    var contoller = Get.find<CartController>();
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: darkFontGrey,
            ),
            onPressed: () {
              Get.back();
            },
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
          title: 'Choose Payment Method'
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: contoller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: yellowColor),
                  onPressed: () async {
                    contoller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[contoller.paymentIndex.value],
                        totalAmount: contoller.totalP.value);
                    await contoller.clearCart();
                    VxToast.show(context, msg: "Order Placed Successfully");
                    Get.offAll(Home());
                  },
                  child:
                      "Place order".text.fontFamily(semibold).size(16).make()),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodImgs.length, (index) {
                return GestureDetector(
                  onTap: () {
                    contoller.changePaymentIndex(index);
                  },
                  child: Container(
                    clipBehavior: Clip.antiAlias,
                    margin: const EdgeInsets.only(bottom: 8, top: 8),
                    height: 120,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                            color: contoller.paymentIndex.value == index
                                ? yellowColor
                                : Colors.transparent,
                            width: 4)),
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.asset(
                          paymentMethodImgs[index],
                          width: double.infinity,
                          colorBlendMode: contoller.paymentIndex.value == index
                              ? BlendMode.darken
                              : BlendMode.color,
                          color: contoller.paymentIndex.value == index
                              ? Colors.black.withOpacity(0.3)
                              : Colors.transparent,
                          height: 120,
                          fit: BoxFit.cover,
                        ),
                        contoller.paymentIndex.value == index
                            ? Transform.scale(
                                scale: 1.3,
                                child: Checkbox(
                                    activeColor: yellowColor,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)),
                                    value: true,
                                    onChanged: (value) {}),
                              )
                            : Container(),
                        Positioned(
                            bottom: 10,
                            right: 10,
                            child: paymentMethods[index]
                                .text
                                .white
                                .fontFamily(semibold)
                                .size(16)
                                .make())
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        ),
      ),
    );
  }
}
