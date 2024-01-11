import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:group_coffee/homepage.dart';
import 'package:group_coffee/login.dart';
import 'package:group_coffee/screens/welcome_screen.dart';
import 'package:group_coffee/signup.dart';
import 'package:group_coffee/wrapper.dart';

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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'EsspressoHUB',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const Wrapper(),
      // home: WelcomeScreen(),
      // initialRoute: '/welcome',
      routes: {
      '/welcome': (context) => const WelcomeScreen(),
      '/signup': (context) => const Signup(),
      '/login': (context) => const Login(),
      '/home': (context) => const Homepage(),
      },
    );
  }
}

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         scaffoldBackgroundColor: Color(0xFF212325),
//       ),
//       initialRoute: '/welcome',
//       routes: {
//         '/welcome': (context) => WelcomeScreen(),
//         '/signup': (context) => SignUpScreen(),
//         '/login': (context) => LoginScreen(),
//         '/home': (context) => HomeScreen(),
//       },
//     );
//   }
// }