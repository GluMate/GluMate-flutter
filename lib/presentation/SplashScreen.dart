import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:glumate_flutter/presentation/register_auth/pages/onboarding_page.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(218, 171, 204, 230),
      body: Center(
        child: AnimatedSplashScreen(
          splash: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.4,
                child: LottieBuilder.asset("assets/Lottie/splash.json"),
              ),
            ],
          ),
          nextScreen: const OnBoardingPage(),
          splashIconSize: 10,
          backgroundColor: Color.fromARGB(218, 202, 228, 247),
        ),
      ),
    );
  }
}
