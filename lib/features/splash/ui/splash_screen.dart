import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movieapp/features/homepage/ui/pages/home_screen.dart';
import 'package:page_transition/page_transition.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    navigateToLoginPage();
  }

  void navigateToLoginPage() {
    Timer.periodic(const Duration(milliseconds: 1500), (timer) {
      Navigator.of(context).pushReplacement(PageTransition(
          child: const HomeScreen(), type: PageTransitionType.fade));

      timer.cancel();
    });
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Image.asset(
            "assets/images/splashlogo.png",
            height: 100,
            width: 100,
          ),
        ),
      ),
    );
  }
}
