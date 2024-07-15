class Profile {
  String username;
  String email;
  String phone;
  String city;
  String country;
  String profilePicture; // Add this field

  Profile({
    required this.username,
    required this.email,
    required this.phone,
    required this.city,
    required this.country,
    this.profilePicture = 'https://via.placeholder.com/150', // Default image URL
  });
}
