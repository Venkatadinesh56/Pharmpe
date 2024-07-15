import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ShareScreen extends StatelessWidget {
  final String productName;
  final String productImageUrl;

  ShareScreen({
    required this.productName,
    required this.productImageUrl,
  });

  // Function to open WhatsApp
  void _openWhatsApp() async {
    String url =
        'https://wa.me/?text=Check out this product: $productName $productImageUrl';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to open Instagram
  void _openInstagram() async {
    String url = 'https://www.instagram.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to open Facebook
  void _openFacebook() async {
    String url = 'https://www.facebook.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  // Function to open Twitter
  void _openTwitter() async {
    String url = 'https://twitter.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Share $productName'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Share $productName with your friends!',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Image.network(
              productImageUrl,
              height: 200,
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _openWhatsApp, // Open WhatsApp
                  icon: Image.asset(
                    'assets/whatsapp.jpeg', // Replace with your WhatsApp icon image
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: _openInstagram, // Open Instagram
                  icon: Image.asset(
                    'assets/ig.png', // Replace with your Instagram icon image
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: _openFacebook, // Open Facebook
                  icon: Image.asset(
                    'assets/facebook.png', // Replace with your Facebook icon image
                    width: 50,
                    height: 50,
                  ),
                ),
                SizedBox(width: 20),
                IconButton(
                  onPressed: _openTwitter, // Open Twitter
                  icon: Image.asset(
                    'assets/twitter.png', // Replace with your Twitter icon image
                    width: 50,
                    height: 50,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Share via other platforms:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // Add more share options here
          ],
        ),
     ),
);
}
}
