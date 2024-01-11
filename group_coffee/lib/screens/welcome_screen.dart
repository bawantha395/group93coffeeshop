import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


import 'package:group_coffee/login.dart';
// import 'package:group_coffee/signup.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        padding: const EdgeInsets.only(top: 100, bottom: 40),
        decoration: const BoxDecoration(
          color: Colors.black,
          image: DecorationImage(
            image: AssetImage("images/bg.png"),
            fit: BoxFit.cover,
            opacity: 0.6,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "EspressoHUB",
              style: GoogleFonts.pacifico(
                fontSize: 50,
                color: Colors.white,
              ),
            ),
            Column(
              children: [
                Text(
                  "Feeling Low? Take a Sip of Coffee",
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.8),
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1,
                  ),
                ),
                const SizedBox(height: 80),
                Material(
                  color: const Color(0xFFE57734),
                  borderRadius: BorderRadius.circular(10),
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Login(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 50),
                      child: const Text(
                        "Get Start",
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
                // SizedBox(height: 20),
                // RichText(
                //   text: TextSpan(
                //     text: "Don’t have an account? ",
                //     style: TextStyle(
                //       color: Colors.white.withOpacity(0.8),
                //       fontSize: 16,
                //     ),
                //     children: [
                //       TextSpan(
                //         text: "Sign Up",
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 16,
                //           fontWeight: FontWeight.bold,
                //         ),
                //         recognizer: TapGestureRecognizer()
                //           ..onTap = () {
                //             Navigator.push(
                //               context,
                //               MaterialPageRoute(
                //                 builder: (context) => const Login(),
                //               ),
                //             );
                //           },
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


