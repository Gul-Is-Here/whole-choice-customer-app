import 'package:flutter/material.dart';

class ReturnPolicyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Privacy Policy'),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: RichText(
            text: const TextSpan(
              style: TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: 'Return Policy\n\n',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                TextSpan(
                  text: 'Last updated: 29/05/2023\n\n',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                ),
                TextSpan(
                  text: '''

Thank you for shopping with Whole Choice. We want to ensure your satisfaction with every purchase made through our ecommerce mobile application ("App"). This Return Policy outlines our guidelines for returning and exchanging products.

1. Eligibility for Returns

1.1 Damaged or Defective Products: If you receive a damaged or defective product, please contact our customer support within [number of days] days of receiving the order. We will arrange for a return or replacement, depending on product availability and your preference.

1.2 Incorrect Orders: If you receive an incorrect product or an item different from what you ordered, please contact our customer support within [number of days] days of receiving the order. We will coordinate the return and send you the correct product or provide a refund.

1.3 Change of Mind: We understand that sometimes you may change your mind about a purchase. For eligible products, you may initiate a return within [number of days] days of receiving the order. The product must be unused, in its original condition, and with all the original tags and packaging intact. Please note that return shipping costs may apply, and refunds will be issued once the returned product is received and inspected.

2. Return Process

2.1 Initiation: To initiate a return, please contact our customer support team through the designated contact channels provided in the App. Provide the order details, reason for the return, and any supporting information or images if required.

2.2 Return Authorization: Our customer support team will guide you through the return authorization process. You may be asked to provide additional details or evidence to support your return request.

2.3 Packaging and Shipping: Please securely package the product to protect it during transit. We recommend using the original packaging whenever possible. You will be responsible for arranging and covering the return shipping costs unless the return is due to a damaged, defective, or incorrect product.

2.4 Refunds and Exchanges: Once we receive the returned product and verify its condition, we will process the refund or exchange as per your request. Refunds will be issued to the original payment method used for the purchase.

3. Exceptions

3.1 Non-Returnable Items: Certain products may not be eligible for return or exchange due to hygiene reasons, perishable nature, or other specific characteristics. These items will be clearly marked as non-returnable on the product page.

3.2 Clearance or Sale Items: Clearance or sale items may have different return policies or may be non-returnable. Please review the product details or contact our customer support for specific information regarding return eligibility for such items.

4. Contact Us

If you have any questions, concerns, or requests related to our Return Policy or the return process, please contact our customer support team through the designated contact channels provided in the App. We are here to assist you and ensure a satisfactory shopping experience.

---

Remember to customize this return policy according to your specific ecommerce app's requirements, including the applicable timeframes, contact information, and any additional details or exceptions that may be relevant to your business. It's also recommended to consult with a legal professional to ensure compliance with relevant laws and regulations in your jurisdiction.

''',
                ),
                // Continue with the rest of your privacy policy text using TextSpan
              ],
            ),
          ),
        ),
      ),
    );
  }
}
