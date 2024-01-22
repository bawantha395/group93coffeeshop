import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';


class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    Future.delayed(
      Duration(seconds: 5), 
      () {
        Navigator.pushReplacementNamed(context, '/welcome');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          
          Image.asset(
            'images/bg.png',
            fit: BoxFit.cover,
          ),
          
          Center(
            child: SpinKitWave(
              color: Color(0xffffa600),
              size: 50.0,
            ),
          ),
        ],
      ),
    );
  }
}