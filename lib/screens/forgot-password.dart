import 'package:flutter/material.dart';
import 'PasswordResetScreen.dart'; // Import your PasswordResetScreen

class ForgotPasswordScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forgot Password'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
              'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA0L3JtMzczYmF0Y2gxNS0yMTctMDFjLmpwZw.jpg',
            ),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your registered email',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Navigate to PasswordResetScreen with the entered email
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PasswordResetScreen(email: emailController.text),
                    ),
                  );
                },
                child: Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
