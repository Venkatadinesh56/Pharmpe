import 'package:app/MainScreen.dart';
import 'package:app/screens/forgot-password.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Home_screen.dart'; // Import the profile screen

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool _obscurePassword = true;

  void _login(BuildContext context) {
    String email = emailController.text;
    String password = passwordController.text;

    // Navigate to profile page on successful login
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>MainScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(
                'https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA0L3JtMzczYmF0Y2gxNS0yMTctMDFjLmpwZw.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Email',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter your email',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  prefixIcon: Icon(Icons.email, color: Colors.white),
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Password',
                  labelStyle: TextStyle(color: Colors.white),
                  hintText: 'Enter your password',
                  hintStyle: TextStyle(color: Colors.white.withOpacity(0.8)),
                  border: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.white),
                  ),
                  prefixIcon: Icon(Icons.lock, color: Colors.white),
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword
                          ? Icons.visibility_off
                          : Icons.visibility,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  _login(context);
                },
                child: Text(
                  'Login',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => {},
                icon: FaIcon(FontAwesomeIcons.google, color: Colors.white),
                label: Text(
                  'Sign in with Google',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () {
                  // Handle Facebook sign-in action
                },
                icon: FaIcon(FontAwesomeIcons.facebook, color: Colors.white),
                label: Text(
                  'Sign in with Facebook',
                  style: TextStyle(color: Colors.white),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextButton(
                onPressed: () {
                   Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>ForgotPasswordScreen())
      );
                  },
                child: Text(
                  'Forgot Password?',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
