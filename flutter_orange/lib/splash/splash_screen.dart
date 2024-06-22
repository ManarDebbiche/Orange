import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_orange/screen/home_screen.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return AnimatedSplashScreen(
          splash: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Lottie.asset(
                    "assets/lottie/Animation - 1718968157433.json",
                  ),
                ],
              ),
            ),
          ),
          nextScreen: HomeScreen(),
          splashIconSize: 400,
          backgroundColor: Colors.white,
        );
      },
    );
  }
}
