import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:group_coffee/forgot.dart';
import 'package:group_coffee/homepage.dart';
import 'package:group_coffee/signup.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isloading = false;

  signin() async {
    setState(() {
      isloading = true;
    });
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email.text, password: password.text);
          Get.off(const Homepage());
    } on FirebaseAuthException catch (e) {
      Get.snackbar("Error ", e.code);
    } catch (e) {
      Get.snackbar("Error ", e.toString());
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isloading
          ? const Center(child: CircularProgressIndicator())
          : Container(
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
                      prefixIcon: Icon(Icons.lock, color: Colors.white70),
                    ),
                    obscureText: true,
                  ),
                  const SizedBox(height: 24),
                  Material(
                    color: const Color(0xFFE57734),
                    borderRadius: BorderRadius.circular(10),
                    child: InkWell(
                      onTap: signin,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: const Text(
                          "Log In",
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
                  const SizedBox(height: 15),
                  TextButton(
                    onPressed: () => Get.to(const Signup()),
                    child: const Text(
                      "Don't have an account ? Register",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Get.to(const Forgot()),
                    child: const Text(
                      "Forgot password ?",
                      style: TextStyle(color: Colors.white70),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
