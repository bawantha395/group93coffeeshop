import 'package:flutter/material.dart';
import 'package:group_coffee/models/cart_model.dart';
import 'package:group_coffee/screens/home_screen.dart';
import 'package:group_coffee/screens/login_screen.dart';
import 'package:group_coffee/screens/signup_screen.dart';
import 'package:group_coffee/screens/welcome_screen.dart';
import 'package:group_coffee/wrapper.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart'; // Import Firebase Core

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyD5VWrwjOWMacdn69J5EBbSGJt307tZa5M", // Replace with actual values
      authDomain: "groupcoffee-ed8f8.firebaseapp.com",
      projectId: "groupcoffee-ed8f8",
      storageBucket: "groupcoffee-ed8f8.appspot.com",
      messagingSenderId: "643171318782",
      appId: "1:643171318782:android:f448c66e36d5d912401eaf",
      // measurementId: "your-measurement-id",
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CartModel()),
        // Add any additional providers you may need
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFF212325),
      ),
      initialRoute: '/wrapper',
      routes: {
        '/wrapper':(context) => Wrapper(),
        '/welcome': (context) => WelcomeScreen(),
        '/signup': (context) => SignUpScreen(),
        '/login': (context) => LoginScreen(),
        '/home': (context) => HomeScreen(),
      },
    );
  }
}
