import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ChatScreen extends StatelessWidget {
  final String sellerName;
  final String sellerEmail;

  ChatScreen({
    required this.sellerName,
    required this.sellerEmail,
  });
  var sellerNumber =
      "+16319669672"; // Example phone number in international format

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Us'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Vendor Name:',
              style: TextStyle(
                fontFamily: 'Bold',
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              sellerName,
              style: TextStyle(fontSize: 16),
            ),
            const Divider(),
            const Text(
              'Email:',
              style: TextStyle(
                fontFamily: 'Bold',
                fontSize: 20,
              ),
            ),
            SizedBox(height: 4),
            Text(
              "gulfarazahmed@emart.com",
              style: TextStyle(fontSize: 16),
            ),
            const Divider(),
            Text(
              'WhatsApp:',
              style: TextStyle(
                fontFamily: 'Bold',
                fontSize: 20,
              ),
            ),
            SizedBox(height: 4),
            GestureDetector(
              onTap: () {
                launch('https://wa.me/$sellerNumber');
              },
              child: Row(
                children: [
                  Icon(
                    Icons.message,
                    color: Colors.green,
                  ),
                  SizedBox(width: 8),
                  Text(
                    sellerNumber,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.green,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            const Divider(),
          ],
        ),
      ),
    );
  }
}
