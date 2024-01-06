import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_coffee/forgot.dart';
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
    } on FirebaseAuthException catch (e) {
      Get.snackbar("error ", e.code);
    } catch (e) {
      Get.snackbar("error ", e.toString());
    }
    setState(() {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isloading?Center(child: CircularProgressIndicator(),): Scaffold(
      appBar: AppBar(
        title: const Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            controller: email,
            decoration: const InputDecoration(hintText: 'Enter email'),
          ),
          TextField(
            controller: password,
            decoration: const InputDecoration(hintText: 'Enter password'),
            obscureText: true,
          ),
          ElevatedButton(
              onPressed: (() => signin()), child: const Text("Login")),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: (() => Get.to(const Signup())),
              child: const Text("Register now")),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: (() => Get.to(const Forgot())),
              child: const Text("Forgot password ?"))
        ],
      ),
    );
  }
}
