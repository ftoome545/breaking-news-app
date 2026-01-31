import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';

import 'features/auth/presentation/views/decision_screen.dart';

class SplashScreen extends StatelessWidget {
  static const String screenRoute = '/splashPage';
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: AnimatedSplashScreen(
      splash: Center(
        child: SizedBox(
          height: MediaQuery.sizeOf(context).height * .4,
          child: Image.asset(
            'images/splash image.jpeg',
            fit: BoxFit.cover,
          ),
        ),
      ),
      nextScreen: const DecisionScreen(),
      splashIconSize: 900,
      duration: 2500,
      pageTransitionType: PageTransitionType.fade,
    ));
  }
}
