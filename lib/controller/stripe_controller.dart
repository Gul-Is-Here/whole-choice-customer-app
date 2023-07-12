import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:whole_choice_customer/consts/colors.dart';
import 'package:whole_choice_customer/views/Profile_screen/profile_screen.dart';
import 'package:whole_choice_customer/views/orders_screen/orders_details.dart';

class StripeController extends GetxController {
  Map<String, dynamic>? paymentIntentData;
  var context;
  RxBool isPayment = false.obs;

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent('20', 'USD');
      await Stripe.instance
          .initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          setupIntentClientSecret:
              'pk_test_51NCgmGA84ClYLg12G4kmhacSLXXdftGoMShB3c2a34OlYXHABx0V09keWN3lFuiDNqdlh2NbRph6lHpcISiCldNS004yiN9TYm',
          paymentIntentClientSecret: paymentIntentData!['client_secret'],
          customFlow: true,
          style: ThemeMode.dark,
          merchantDisplayName: 'Gul Faraz Ahmed',
        ),
      )
          .then((value) {
        // Payment sheet initialized
        isPayment.value = false;
        update(); // Update the controller to re-render the UI
      });

      // Display payment sheet
      displayPaymentSheet(context);
    } catch (e) {
      // Handle payment exception
      print('Payment exception: $e');
    }
  }

  displayPaymentSheet(context) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar(
          'Payment', 'Your order is place we let you know when order confirmed',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: yellowColor,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 5));
      Navigator.of(context).pop(MaterialPageRoute(builder: (context) {
        return const OrderDetailsScreen();
      }));
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  Future<Map<String, dynamic>> createPaymentIntent(
    String amount,
    String currency,
  ) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount('20'),
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        body: body,
        headers: {
          'Authorization':
              'Bearer sk_test_51NCgmGA84ClYLg12f9lrXFgkBNog3lJ4Du1YWcesyhUlgkt6U7MKS4klsojnSl3OFVt9T8tqLXoXwZDRlaOLdAyt00bDJijyZT',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      return jsonDecode(response.body);
    } catch (err) {
      // Handle error
      print('Payment intent error: $err');
      return {};
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
