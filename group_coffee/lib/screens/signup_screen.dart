import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:group_coffee/screens/login_screen.dart';
// import 'package:coffee_app/screens/home_screen.dart';

class SignUpScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Sign Up",
              style: GoogleFonts.pacifico(
                fontSize: 30,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 20),
            // TextFormField(
            //   style: TextStyle(color: Colors.white),
            //   decoration: InputDecoration(
            //     labelText: "Username",
            //     labelStyle: TextStyle(color: Colors.white),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.white),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.white),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 10),
            TextFormField(
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Email Address",
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            TextFormField(
              obscureText: true,
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Password",
                labelStyle: TextStyle(color: Colors.white),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 10),
            // TextFormField(
            //   style: TextStyle(color: Colors.white),
            //   decoration: InputDecoration(
            //     labelText: "Address",
            //     labelStyle: TextStyle(color: Colors.white),
            //     focusedBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.white),
            //     ),
            //     enabledBorder: OutlineInputBorder(
            //       borderSide: BorderSide(color: Colors.white),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20),
            Material(
              color: Color(0xFFE57734),
              borderRadius: BorderRadius.circular(10),
              child: InkWell(
                onTap: () {
                  // Perform SignUp logic
                  // After successful signup, navigate to HomeScreen
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  );
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  alignment: Alignment.center,
                  child: Text(
                    "Sign Up",
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
