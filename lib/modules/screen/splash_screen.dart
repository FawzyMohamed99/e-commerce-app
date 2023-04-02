import 'package:fashion/authentication_screen/layout/layout_screen.dart';
import 'package:fashion/constant/constanc.dart';
import 'package:fashion/modules/screen/home_page_screen.dart';
import 'package:fashion/modules/screen/login_screen.dart';
import 'package:fashion/shared/network/local_network.dart';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 4), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                token != null && token != "" ? LayoutScreen() : LoginScreen()),
      );
    });
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(bottom: 20),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: Image.asset(
                  "images/splash_screen.png",
                  height: double.infinity,
                  width: double.infinity,
                ),
              ),
            ),
            const Text(
              'Developed by Fawzy Mohamed',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
      ),
    );
  }
}
