import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_coffee/login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController displayName = TextEditingController();
  TextEditingController shippingAddressController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();

  signup() async {
  try {
    print("Attempting to sign up...");

    // Validate input fields
    if (!isValidEmail(email.text)) {
      Get.snackbar("Error", "Enter a valid email address");
      return;
    }

    if (password.text.length < 6) {
      Get.snackbar("Error", "Password must be at least 6 characters");
      return;
    }

    if (displayName.text.isEmpty) {
      Get.snackbar("Error", "Display Name cannot be empty");
      return;
    }

    if (shippingAddressController.text.isEmpty) {
      Get.snackbar("Error", "Shipping Address cannot be empty");
      return;
    }

    if (!isValidPhoneNumber(phoneNumberController.text)) {
      Get.snackbar("Error", "Enter a valid 10-digit phone number");
      return;
    }

    // Create user with email and password
    UserCredential userCredential =
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email.text,
      password: password.text,
    );

    // Get the current user
    User? user = userCredential.user;

    if (user != null) {
      print("User created: ${user.email}");

      // Store user information in Firestore
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'email': email.text,
        'displayName': displayName.text,
        'shippingAddress': shippingAddressController.text,
        'phoneNumber': phoneNumberController.text,
        // Add more fields as needed
      });

      print("User data stored in Firestore");
      Get.offAll(const Login());
    } else {
      print("User is null. Signup failed.");
    }
  } on FirebaseAuthException catch (e) {
    print("Firebase Auth Error: ${e.code}");
    Get.snackbar("Error", e.message ?? "An error occurred");
  } catch (e) {
    print("Error: $e");
    Get.snackbar("Error", e.toString());
  }
}

bool isValidEmail(String email) {
  // Add your email validation logic here
  // You can use a regex or any other method to validate the email format
  return true;
}

bool isValidPhoneNumber(String phoneNumber) {
  // Validate if the phone number has 10 digits
  return phoneNumber.length == 10 && int.tryParse(phoneNumber) != null;
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("images/bg.png"),
            fit: BoxFit.cover,
            opacity: 0.6,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "EspressoHUB",
              textAlign: TextAlign.center,
              style: GoogleFonts.pacifico(
                fontSize: 40,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 48),
            TextField(
              controller: email,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Email Address',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.email, color: Colors.white70),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: password,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.lock, color: Colors.white70),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: displayName,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Display Name',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.person, color: Colors.white70),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: shippingAddressController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Shipping Address',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.location_on, color: Colors.white70),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: phoneNumberController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: 'Phone Number',
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.white24,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                prefixIcon: const Icon(Icons.phone, color: Colors.white70),
              ),
            ),
            const SizedBox(height: 24),
            Material(
              color: const Color(0xFFE57734),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: signup,
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: const Text(
                    "Sign Up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
