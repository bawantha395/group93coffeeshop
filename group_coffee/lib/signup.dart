import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_coffee/login.dart';
import 'package:group_coffee/wrapper.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  TextEditingController displayName = TextEditingController();

  signup() async {
    try {
      print("Attempting to sign up...");

      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text,
        password: password.text,
      );

      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      if (user != null) {
        print("User created: ${user.email}");

        // Store user information in Firestore
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': email.text,
          'displayName': displayName.text,
          // Add more fields as needed
        });

        print("User data stored in Firestore");
        Get.offAll(const Login());
      } else {
        print("User is null. Signup failed.");
      }
    } on FirebaseAuthException catch (e) {
      print("Firebase Auth Error: ${e.code}");
      Get.snackbar("Error", e.code);
    } catch (e) {
      print("Error: $e");
      Get.snackbar("Error", e.toString());
    }
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
                prefixIcon: Icon(Icons.email, color: Colors.white70),
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
                prefixIcon: Icon(Icons.lock, color: Colors.white70),
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
                prefixIcon: Icon(Icons.person, color: Colors.white70),
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
