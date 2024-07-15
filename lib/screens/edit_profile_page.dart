import 'dart:io';

import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'profile.dart';

class EditProfilePage extends StatefulWidget {
  final Profile profile;

  EditProfilePage({required this.profile});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController _usernameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _cityController;
  late TextEditingController _countryController;
  String? _selectedImagePath; // Track the selected image path

  @override
  void initState() {
    super.initState();
    _usernameController = TextEditingController(text: widget.profile.username);
    _emailController = TextEditingController(text: widget.profile.email);
    _phoneController = TextEditingController(text: widget.profile.phone);
    _cityController = TextEditingController(text: widget.profile.city);
    _countryController = TextEditingController(text: widget.profile.country);
    _selectedImagePath = widget.profile.profilePicture; // Initialize with current profile picture
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _cityController.dispose();
    _countryController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    final updatedProfile = Profile(
      username: _usernameController.text,
      email: _emailController.text,
      phone: _phoneController.text,
      city: _cityController.text,
      country: _countryController.text,
      profilePicture: _selectedImagePath ?? widget.profile.profilePicture,
    );

    Navigator.pop(context, updatedProfile);
  }

  Future<void> _openGallery() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );

    if (result != null) {
      setState(() {
        _selectedImagePath = result.files.single.path!;
      });
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        leading: IconButton(
          icon: Icon(Icons.cancel),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: _selectedImagePath != null
                    ? FileImage(File(_selectedImagePath!))
                    : NetworkImage('https://via.placeholder.com/150'),
              ),
              SizedBox(height: 10),
              TextButton.icon(
                onPressed: _openGallery,
                icon: Icon(Icons.camera_alt),
                label: Text('Change Photo'),
              ),
              SizedBox(height: 20),
              _buildTextField('Your Username', _usernameController),
              _buildTextField('Your Email', _emailController),
              _buildTextField('Your Phone', _phoneController),
              _buildTextField('City, State', _cityController),
              _buildTextField('Country', _countryController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveProfile,
                child: Text('Save'),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(fontSize: 18),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey,
          ),
        ),
        TextField(
          controller: controller,
          obscureText: obscureText,
          decoration: InputDecoration(
            hintText: label,
            hintStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        SizedBox(height: 20),
      ],
    );
  }
}
