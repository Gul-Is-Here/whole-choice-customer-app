import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
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
                  text: 'Privacy Policy\n\n',
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

This Privacy Policy describes how Whole Choice ("we," "us," or "our") collects, uses, and shares information when you use our ecommerce mobile application ("App").

Information We Collect
1.1 Personal Information: We may collect personal information that you voluntarily provide to us when you use our App. This may include your name, email address, phone number, shipping address, billing information, and other information necessary for order processing and customer support.

1.2 Device Information: When you use our App, we may automatically collect certain information about your device, including the type of device, operating system, unique device identifiers, IP address, mobile network information, and device settings.

1.3 Usage Information: We may collect information about how you use our App, including the pages you view, the products you browse or purchase, the time and date of your visits, and other interactions with the App.

How We Use Your Information
2.1 Provide and Improve our Services: We use the collected information to provide and improve our App, process orders, fulfill customer requests, personalize your experience, and enhance the functionality and security of our services.

2.2 Communication: We may use your contact information to communicate with you regarding your orders, provide important updates, respond to your inquiries, and send promotional and marketing materials. You can opt-out of receiving marketing communications at any time.

2.3 Analytics and Aggregated Data: We may use the collected information for analytics purposes, such as analyzing trends, monitoring usage patterns, and measuring the effectiveness of our marketing campaigns. We may also aggregate and anonymize data to create statistical and analytical insights.

Information Sharing
3.1 Service Providers: We may share your information with trusted third-party service providers who assist us in operating our App, processing payments, delivering products, analyzing data, and providing customer support. These service providers are obligated to handle your information securely and only use it for the intended purpose.

3.2 Legal Compliance: We may disclose your information if required by law, regulation, or legal process, or if we believe disclosure is necessary to protect our rights, prevent fraud, or respond to a government request.

3.3 Business Transfers: In the event of a merger, acquisition, or sale of our business assets, your information may be transferred to the acquiring entity or parties involved in the transaction.

Data Security
We implement industry-standard security measures to protect your information from unauthorized access, disclosure, alteration, or destruction. However, please note that no method of transmission over the internet or electronic storage is 100% secure, and we cannot guarantee absolute security.

Your Choices and Rights
You have certain rights and choices regarding the information we collect and how it is used:

5.1 Access and Update: You can access and update your personal information by logging into your account or contacting us directly.

5.2 Opt-Out: You can opt-out of receiving marketing communications by following the instructions provided in the communication or contacting us.

5.3 Data Retention: We retain your information for as long as necessary to fulfill the purposes outlined in this Privacy Policy, unless a longer retention period is required or permitted by law.

Children's Privacy
Our App is not intended for children under the age of 13. We do not knowingly collect personal information from children
User under the age of 13. If you are a parent or guardian and believe that your child has provided us with personal information, please contact us, and we will take steps to remove that information from our systems.

Third-Party Links and Services
Our App may contain links to third-party websites, services, or applications that are not owned or controlled by us. This Privacy Policy does not apply to those third-party platforms. We recommend reviewing the privacy policies of those platforms before providing any personal information.

Updates to this Privacy Policy
We may update this Privacy Policy from time to time to reflect changes in our practices or applicable laws. We will notify you of any material updates by posting the revised Privacy Policy on our App or through other communication channels. We encourage you to review this Privacy Policy periodically for the latest information on our privacy practices.

Contact Us
If you have any questions, concerns, or requests regarding this Privacy Policy or our data practices, please contact us at [Contact Information].


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
