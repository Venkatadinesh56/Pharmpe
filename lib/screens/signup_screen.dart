import 'package:flutter/material.dart';
import 'package:http/http.dart' as http; // Import http package for API calls

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  Future<void> registerUser(BuildContext context) async {
    String url = 'http://your_api_endpoint/register'; // Replace with your API endpoint

    try {
      var response = await http.post(Uri.parse(url), body: {
        'name': nameController.text,
        'email': emailController.text,
        'number': numberController.text,
        'password': passwordController.text,
        'confirm_password': confirmPasswordController.text,
      });

      if (response.statusCode == 200) {
        // Handle successful registration, e.g., show confirmation message
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text('Registration Successful'),
            content: Text('You can now login with your credentials.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close dialog
                  Navigator.pushNamed(context, '/login'); // Navigate to login screen
                },
                child: Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Handle registration failure, show error message or retry option
        print('Registration failed. Status code: ${response.statusCode}');
      }
    } catch (e) {
      // Handle network or server errors
      print('Error during registration: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Sign Up'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://images.rawpixel.com/image_800/cHJpdmF0ZS9sci9pbWFnZXMvd2Vic2l0ZS8yMDIyLTA0L3JtMzczYmF0Y2gxNS0yMTctMDFjLmpwZw.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  hintText: 'Enter your name',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8), // Custom background color for text field
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  hintText: 'Enter your email',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8), // Custom background color for text field
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: numberController,
                decoration: InputDecoration(
                  labelText: 'Number',
                  hintText: 'Enter your phone number',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8), // Custom background color for text field
                ),
              ),
              SizedBox(height: 20),
              TextField(
                controller: passwordController,
                obscureText: _obscurePassword,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter your password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8), // Custom background color for text field
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscurePassword ? Icons.visibility_off : Icons.visibility,
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
              TextField(
                controller: confirmPasswordController,
                obscureText: _obscureConfirmPassword,
                decoration: InputDecoration(
                  labelText: 'Confirm Password',
                  hintText: 'Confirm your password',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.8), // Custom background color for text field
                  suffixIcon: IconButton(
                    icon: Icon(
                      _obscureConfirmPassword ? Icons.visibility_off : Icons.visibility,
                    ),
                    onPressed: () {
                      setState(() {
                        _obscureConfirmPassword = !_obscureConfirmPassword;
                      });
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  registerUser(context);
                },
                child: Text('Sign Up'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
