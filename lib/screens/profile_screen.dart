import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final String email;

  ProfileScreen({required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Center(
              child: CircleAvatar(
                radius: 50,
                backgroundImage: AssetImage('assets/image.png'),
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                'User Profile',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Email:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 5),
            Text(
              email,
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add logout functionality here
                Navigator.pop(context); // Navigate back to the previous screen
              },
              child: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                textStyle: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
