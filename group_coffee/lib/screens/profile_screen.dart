import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_coffee/screens/welcome_screen.dart';
import 'package:group_coffee/widgets/home_bottom_bar.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      // If the user is not logged in, navigate to WelcomeScreen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => WelcomeScreen()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 33, 34, 35),
        leading: IconButton(
          icon: Icon(Icons.sort_rounded),
          color: Colors.grey,
          onPressed: () {
            // Add your sort functionality here
          },
        ),
        title: Text(
          'Profile',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            color: Colors.grey,
            onPressed: () {
              // Add your notification functionality here
            },
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: FirebaseFirestore.instance.collection('users').doc(user!.uid).get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data == null) {
            // If user data is not found, handle accordingly
            return Center(child: Text('User data not found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;

          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 80,
                    backgroundImage: AssetImage(
                        'images/profile_image.png'), // Replace with the actual image path
                  ),
                  SizedBox(height: 20),
                  Text(
                    userData['displayName'] ?? 'John Doe',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    user.email ?? 'john.doe@email.com',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 18,
                    ),
                  ),
                  SizedBox(height: 20),
                  Divider(
                    color: Colors.grey,
                    thickness: 1,
                  ),
                  SizedBox(height: 20),
                  ProfileDetailItem(
                    icon: Icons.location_on,
                    label: 'Shipping Address:',
                    value: userData['shippingAddress'] ?? 'N/A',
                  ),
                  SizedBox(height: 10),
                  ProfileDetailItem(
                    icon: Icons.phone,
                    label: 'Phone Number:',
                    value: userData['phoneNumber'] ?? 'N/A',
                  ),
                  SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      // Add logout functionality here

                      // Navigate to WelcomeScreen after logout
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => WelcomeScreen()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red, // Set button color to red
                      padding: EdgeInsets.symmetric(vertical: 16, horizontal: 32),
                    ),
                    child: Text(
                      'Logout',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: HomeBottomBar(favoriteItems: Set()), // Pass an empty Set as an example
    );
  }
}

class ProfileDetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  ProfileDetailItem({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          icon,
          color: Colors.white,
          size: 24,
        ),
        SizedBox(width: 12),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            SizedBox(height: 4),
            Text(
              value,
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
