import 'package:app/screens/login_screen.dart';
import 'package:app/screens/signup_screen.dart';
import 'package:flutter/material.dart';

class IntroScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.zero,
        child: Container(), // Empty container to remove the app bar
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  'assets/heart.png',
                  colorBlendMode: BlendMode.overlay,
                  width: 100,
                ),
                Text(
                  'Welcome to Pharmpe App',
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white, // Ensure the text is readable
                    shadows: [
                      Shadow(
                        offset: Offset(1.0, 1.0),
                        blurRadius: 3.0,
                        color: Color.fromARGB(255, 0, 0, 0),
                      ),
                    ],
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
                  child: Text('Login'),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                     Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>SignupScreen())
      );
                  
                  },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
