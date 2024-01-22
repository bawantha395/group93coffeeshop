import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:group_coffee/login.dart';

class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController displayNameController = TextEditingController();
  final TextEditingController shippingAddressController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  File? _image;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage = await _picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  Future<String?> _uploadImage(File image) async {
    try {
      String fileName = 'profile_pictures/${DateTime.now().millisecondsSinceEpoch}_${image.path.split('/').last}';
      Reference storageRef = FirebaseStorage.instance.ref().child(fileName);
      UploadTask uploadTask = storageRef.putFile(image);
      TaskSnapshot snapshot = await uploadTask;
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      print("Error uploading image: $e");
      Get.snackbar("Error", "Failed to upload profile picture");
      return null;
    }
  }

  Future<void> signup() async {
    try {
      // Validate input fields
      // ... (Add your validation logic here)

      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );

      User? user = userCredential.user;

      if (user != null) {
        String? profilePictureUrl;
        if (_image != null) {
          profilePictureUrl = await _uploadImage(_image!);
          if (profilePictureUrl == null) {
            return;
          }
        }

        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'email': emailController.text,
          'displayName': displayNameController.text,
          'shippingAddress': shippingAddressController.text,
          'phoneNumber': phoneNumberController.text,
          'profilePictureUrl': profilePictureUrl ?? '',
        });

        Get.offAll(const Login());
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error", e.message ?? "An error occurred");
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    double horizontalPadding = screenSize.width * 0.05;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/bg.png"), // Replace with your image path
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                Colors.black.withOpacity(0.5), // Adjust the opacity as needed
                BlendMode.darken,
              ),
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: screenSize.height * 0.08),
              Text(
                "EspressoHUB",
                textAlign: TextAlign.center,
                style: GoogleFonts.pacifico(
                  fontSize: screenSize.width * 0.1,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: screenSize.height * 0.05),
              TextField(
                controller: emailController,
                style: TextStyle(color: Colors.white),
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
              SizedBox(height: screenSize.height * 0.02),
              TextField(
                controller: passwordController,
                style: TextStyle(color: Colors.white),
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
              SizedBox(height: screenSize.height * 0.02),
              TextField(
                controller: displayNameController,
                style: TextStyle(color: Colors.white),
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
              SizedBox(height: screenSize.height * 0.02),
              TextField(
                controller: shippingAddressController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Shipping Address',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.location_on, color: Colors.white70),
                ),
              ),
              SizedBox(height: screenSize.height * 0.02),
              TextField(
                controller: phoneNumberController,
                style: TextStyle(color: Colors.white),
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  labelStyle: TextStyle(color: Colors.white70),
                  filled: true,
                  fillColor: Colors.white24,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Icon(Icons.phone, color: Colors.white70),
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              InkWell(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: screenSize.width * 0.15,
                  backgroundColor: Colors.white24,
                  backgroundImage: _image != null ? FileImage(_image!) : null,
                  child: _image == null
                      ? Icon(Icons.add_a_photo, color: Colors.white70, size: screenSize.width * 0.1)
                      : null,
                ),
              ),
              SizedBox(height: screenSize.height * 0.03),
              Material(
                color: const Color(0xFFE57734),
                borderRadius: BorderRadius.circular(10),
                child: InkWell(
                  onTap: signup,
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: screenSize.height * 0.02),
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
              SizedBox(height: screenSize.height * 0.05),
            ],
          ),
        ),
      ),
    );
  }
}
