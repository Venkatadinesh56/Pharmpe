import 'package:flutter/material.dart';
import 'edit_profile_page.dart';
import 'profile.dart';
import 'address_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  Profile _profile = Profile(
    username: 'Kamrul Hossain',
    email: 'mayasasha@gmail.com',
    phone: '+1.415.111.0000',
    city: 'San Francisco, CA',
    country: 'USA',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage('https://via.placeholder.com/150'),
                  ),
                  SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _profile.username,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      Text('Lorem Ipsum is simply dummy'),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 20),
              _buildProfileOption(context, 'Edit Profile', Icons.edit),
              _buildProfileOption(context, 'My Medicine', Icons.medical_services),
              _buildProfileOption(context, 'Order History', Icons.history),
              _buildProfileOption(context, 'My Address', Icons.home),
              _buildProfileOption(context, 'Payment', Icons.payment),
              _buildProfileOption(context, 'Settings', Icons.settings),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Implement logout functionality
                },
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50), backgroundColor: Colors.red,
                  textStyle: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileOption(BuildContext context, String title, IconData icon) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: () async {
        if (title == 'Edit Profile') {
          final updatedProfile = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => EditProfilePage(profile: _profile)),
          );

          if (updatedProfile != null) {
            setState(() {
              _profile = updatedProfile;
            });
          }
        } else if (title == 'My Address') {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddressPage(cartItems: [])),
          );
        }
        // Add navigation for other options if needed
      },
    );
  }
}
