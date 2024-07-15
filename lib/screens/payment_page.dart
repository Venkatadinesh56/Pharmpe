import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:async';
import 'dart:math';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SelectCardPage(),
    );
  }
}

class SelectCardPage extends StatefulWidget {
  @override
  _SelectCardPageState createState() => _SelectCardPageState();
}

class _SelectCardPageState extends State<SelectCardPage> {
  String? cardType;
  TextEditingController upiController = TextEditingController();
  final double totalAmount = 123.45; // Example total amount

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void initiateUPIPayment() {
    if (cardType == 'UPI ID') {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Initiating Payment...'),
              SizedBox(height: 10),
              Text('UPI ID: ${upiController.text}'),
              SizedBox(height: 10),
              Text('Amount: \$${totalAmount.toStringAsFixed(2)}'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => OTPVerificationPage(),
                  ),
                );
              },
              child: Text('Proceed to Verify OTP'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Payment Option'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Select your payment option',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Expanded(
              child: ListView(
                children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('Debit Card'),
                    trailing: Radio<String>(
                      value: 'Debit Card',
                      groupValue: cardType,
                      onChanged: (value) {
                        setState(() {
                          cardType = value;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCardPage()),
                        );
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('Credit Card'),
                    trailing: Radio<String>(
                      value: 'Credit Card',
                      groupValue: cardType,
                      onChanged: (value) {
                        setState(() {
                          cardType = value;
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCardPage()),
                        );
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.account_balance_wallet),
                    title: Text('UPI ID'),
                    trailing: Radio<String>(
                      value: 'UPI ID',
                      groupValue: cardType,
                      onChanged: (value) {
                        setState(() {
                          cardType = value;
                        });
                      },
                    ),
                  ),
                  if (cardType == 'UPI ID') ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          TextField(
                            controller: upiController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Enter UPI ID',
                            ),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: initiateUPIPayment,
                              child: Text('Proceed Payment'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                  ListTile(
                    leading: Image.network(
                      'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYQ3uhlEkLwNJ9Y6kjLphe_irfN1i9H1pCMw&s',
                      width: 40,
                      height: 40,
                    ),
                    title: Text('Google Pay'),
                    trailing: Radio<String>(
                      value: 'Google Pay',
                      groupValue: cardType,
                      onChanged: (value) {
                        setState(() {
                          cardType = value;
                        });
                        _launchURL('https://pay.google.com/');
                      },
                    ),
                  ),
                  ListTile(
                    leading: Image.network(
                      'data:image/png;base64,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',
                      width: 40,
                      height: 40,
                    ),
                    title: Text('PhonePe'),
                    trailing: Radio<String>(
                      value: 'PhonePe',
                      groupValue: cardType,
                      onChanged: (value) {
                        setState(() {
                          cardType = value;
                        });
                        _launchURL('https://www.phonepe.com/');
                      },
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.money),
                    title: Text('Cash on Delivery'),
                    trailing: Radio<String>(
                      value: 'Cash on Delivery',
                      groupValue: cardType,
                      onChanged: (value) {
                        setState(() {
                          cardType = value;
                        });
                      },
                    ),
                  ),
                  if (cardType == 'Cash on Delivery') ...[
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                            style: TextStyle(
                                fontSize: 18.0, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        CircularProgressIndicator(),
                                        SizedBox(height: 10),
                                        Text('Processing Order...'),
                                      ],
                                    ),
                                  ),
                                );

                                Future.delayed(Duration(seconds: 2), () {
                                  Navigator.pop(context);
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Icon(Icons.check_circle,
                                              color: Colors.green, size: 80),
                                          SizedBox(height: 10),
                                          Text('Order Placed Successfully'),
                                        ],
                                      ),
                                      actions: <Widget>[
                                        TextButton(
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: Text('Back to Home'),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                              },
                              child: Text('Proceed'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AddCardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Card'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Add your payment option',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              elevation: 5.0,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Card Number',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Cardholder Name',
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Expiry Date',
                            ),
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'CVC / CVV',
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20.0),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OTPVerificationPage(),
                            ),
                          );
                        },
                        child: Text('Pay'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OTPVerificationPage extends StatefulWidget {
  @override
  _OTPVerificationPageState createState() => _OTPVerificationPageState();
}

class _OTPVerificationPageState extends State<OTPVerificationPage> {
  TextEditingController otpController = TextEditingController();
  final String predefinedOTP = '123456';
  Timer? _timer;
  int _start = 180;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  

  void startTimer() {
    const oneSec = Duration(seconds: 1);
    _timer = Timer.periodic(oneSec, (timer) {
      if (_start == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  void verifyOTP() {
    String enteredOtp = otpController.text.trim();
      print('Entered OTP: $enteredOtp');
  print('Predefined OTP: $predefinedOTP');
    if (enteredOtp ==predefinedOTP) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 80),
              SizedBox(height: 10),
              Text('Payment Successful..!'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                Navigator.pop(context);
                Navigator.pop(context); // Navigate back to home
              },
              child: Text('Back to Home'),
            ),
          ],
        ),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid OTP'),
          content: Text('Please enter the correct OTP.'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        ),
      );
    }
  }
  

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('OTP Verification'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              'Verify the OTP below',
              style: TextStyle(fontSize: 16.0),
            ),
            SizedBox(height: 20.0),
            TextField(
              controller: otpController,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter OTP',
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'Time remaining: ${_start ~/ 60}:${(_start % 60).toString().padLeft(2, '0')}',
              style: TextStyle(fontSize: 16.0, color: Colors.red),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: verifyOTP,
              child: Text('Proceed'),
            ),
          ],
        ),
      ),
    );
  }
}
