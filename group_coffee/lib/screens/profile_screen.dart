import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:group_coffee/screens/welcome_screen.dart';
import 'package:group_coffee/widgets/home_bottom_bar.dart';
import 'package:group_coffee/screens/edit_profile_screen.dart';


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
  backgroundColor: Colors.black,
  appBar: AppBar(
    backgroundColor: Color.fromARGB(255, 33, 34, 35),
    leading: IconButton(
      icon: Icon(Icons.sort_rounded),
      color: Colors.grey,
      onPressed: () {},
    ),
    title: Text(
      'Profile',
      style: TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
    ),
  ),
  body: SingleChildScrollView(
    
    child: FutureBuilder<DocumentSnapshot>(
      
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

        // Retrieve the profile picture URL
        String? profilePictureUrl = userData['profilePictureUrl'];

        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: profilePictureUrl != null
                      ? NetworkImage(profilePictureUrl)
                          as ImageProvider<Object>?
                      : AssetImage('images/profile_image.png')
                          as ImageProvider<Object>?,
                          
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
                SizedBox(height: 20),
                TextButton.icon(
                  // Add an edit button
                  onPressed: () {
                    // Navigate to the edit profile screen
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              EditProfileScreen(userData: userData)),
                    );
                  },
                  icon: Icon(Icons.edit, color: Colors.white),
                  label: Text('Edit Profile',
                      style: TextStyle(color: Colors.white)),
                ),
                
                SizedBox(height: 20),
                Divider(
                  color: Colors.grey,
                  thickness: 1,
                ),
                // SizedBox(height: 10),
                // Text(
                //   user.email ?? 'john.doe@email.com',
                //   style: TextStyle(
                //     color: Colors.grey,
                //     fontSize: 18,
                    
                //   ),
                // ),
                

                SizedBox(height: 20),
                ProfileDetailItem(
                  icon: Icons.email,
                  label: 'Email:',
                  value: userData['email'] ?? 'N/A',
                ),
                SizedBox(height: 10),
                ProfileDetailItem(
                  icon: Icons.phone,
                  label: 'Phone Number:',
                  value: userData['phoneNumber'] ?? 'N/A',
                ),
                SizedBox(height: 10),
                ProfileDetailItem(
                  icon: Icons.location_on,
                  label: 'Shipping Address:',
                  value: userData['shippingAddress'] ?? 'N/A',
                ),
                SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () async {
                    // Sign out the user
                    await FirebaseAuth.instance.signOut();

                    // Navigate to WelcomeScreen after logout
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color.fromARGB(255, 223, 117, 31),
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
SizedBox(width: 18),
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