import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:whole_choice_customer/views/Profile_screen/profile_screen.dart';
import 'package:whole_choice_customer/views/orders_screen/orders_details.dart';

// import 'package:whole_choice_customer/views/cart_screen/stripe_payment_screen.dart';

import '../../consts/consts.dart';
import '../../consts/iconList.dart';
import '../../controller/cart_controller.dart';
import '../../controller/stripe_controller.dart';
import '../../home-screens/home.dart';
import '../../widget_common/loading_indicator.dart';

class PaymentMethod extends StatelessWidget {
  const PaymentMethod({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    var stripecontroller = Get.put(StripeController());

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
          title: const Text(
            'Choose Payment Method',
            style: TextStyle(
              fontFamily: semibold,
              color: darkFontGrey,
            ),
          ),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: yellowColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    if (controller.paymentIndex.value == 1) {
                      stripecontroller.makePayment().then((value) {
                        controller.placeMyOrder(
                          orderPaymentMethod:
                              paymentMethods[controller.paymentIndex.value],
                          totalAmount: controller.totalP.value,
                        );
                        controller.clearCart();
                        VxToast.show(context, msg: "Inquiry Sent Successfully");
                        // Get.off(
                        //     ProfileScreen()); // Navigate to the profile screen
                      });
                    }
                  },
                  child: Obx(
                    () => Text(
                      stripecontroller.isPayment.value
                          ? 'Processing...'
                          : 'Pay',
                      style: const TextStyle(
                        fontFamily: semibold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Obx(
            () => Column(
              children: List.generate(paymentMethodImgs.length, (index) {
                if (index != 0 && index != 2) {
                  return GestureDetector(
                    onTap: () {
                      controller.changePaymentIndex(index);
                    },
                    child: Container(
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.only(bottom: 8, top: 8),
                      height: 120,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: controller.paymentIndex.value == index
                              ? yellowColor
                              : Colors.transparent,
                          width: 4,
                        ),
                      ),
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: [
                          Image.asset(
                            paymentMethodImgs[index],
                            width: double.infinity,
                            colorBlendMode:
                                controller.paymentIndex.value == index
                                    ? BlendMode.darken
                                    : BlendMode.color,
                            color: controller.paymentIndex.value == index
                                ? Colors.black.withOpacity(0.3)
                                : Colors.transparent,
                            height: 120,
                            fit: BoxFit.cover,
                          ),
                          if (controller.paymentIndex.value == index)
                            Transform.scale(
                              scale: 1.3,
                              child: Checkbox(
                                activeColor: yellowColor,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                value: true,
                                onChanged: (value) {},
                              ),
                            ),
                          Positioned(
                            bottom: 10,
                            right: 10,
                            child: Text(
                              paymentMethods[index],
                              style: const TextStyle(
                                color: Colors.white,
                                fontFamily: semibold,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                } else {
                  return const SizedBox
                      .shrink(); // Skip rendering index 0 and 2
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
