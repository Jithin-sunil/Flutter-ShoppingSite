import 'package:flutter/material.dart';

class MyProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Profile', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.pinkAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              // Profile Image
              Center(
                child: Stack(
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundImage: AssetImage('assets/profile_photo.jpg'), // Change with user's image
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: Colors.white,
                        child: Icon(Icons.camera_alt, color: Colors.pinkAccent),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),

              // User Information
              Card(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                elevation: 3,
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      profileInfo(Icons.person, 'Name', 'John Doe'),
                      profileInfo(Icons.email, 'Email', 'johndoe@example.com'),
                      profileInfo(Icons.phone, 'Contact', '+1234567890'),
                      profileInfo(Icons.location_on, 'Address', '123 Street, NY'),
                      profileInfo(Icons.location_city, 'District', 'New York'),
                      profileInfo(Icons.place, 'Place', 'Downtown'),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  actionButton(Icons.edit, 'Edit Profile', Colors.purple, () {
                    // Navigate to Edit Profile Page
                  }),
                  actionButton(Icons.lock, 'Change Password', Colors.red, () {
                    // Navigate to Change Password Page
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget profileInfo(IconData icon, String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, color: Colors.pinkAccent),
          SizedBox(width: 10),
          Expanded(
            child: Text(
              '$title: $value',
              style: TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  Widget actionButton(IconData icon, String label, Color color, VoidCallback onPressed) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: Colors.white),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
