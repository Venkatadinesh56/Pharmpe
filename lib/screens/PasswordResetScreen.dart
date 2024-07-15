import 'package:app/screens/login_screen.dart';
import 'package:flutter/material.dart';

class PasswordResetScreen extends StatefulWidget {
  final String email;

  PasswordResetScreen({required this.email});

  @override
  _PasswordResetScreenState createState() => _PasswordResetScreenState();
}

class _PasswordResetScreenState extends State<PasswordResetScreen> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  bool _obscureText = true;

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<void> _resetPassword(BuildContext context) async {
    // Replace with your actual reset password logic (API call, etc.)
    print('Email: ${widget.email}');
    print('New Password: ${newPasswordController.text}');
    print('Confirm Password: ${confirmPasswordController.text}');

    // Simulate a delay for the demo (replace with actual async logic)
    await Future.delayed(Duration(seconds: 2));

    // Navigate back to login screen after successful password reset
    Navigator.popUntil(context, ModalRoute.withName('/login'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reset Password'),
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
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Enter new password for ${widget.email}',
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(height: 20),
              TextField(
                controller: newPasswordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'New Password',
                  hintText: 'Enter your new password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: confirmPasswordController,
                obscureText: _obscureText,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Re-enter your new password',
                  border: OutlineInputBorder(),
                  suffixIcon: IconButton(
                    icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off),
                    onPressed: _togglePasswordVisibility,
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                   Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>LoginScreen())
      );
                  
                },
                child: Text('Confirm Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
