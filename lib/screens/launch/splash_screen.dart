import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart'; // Import SpinKit
import 'package:shared_preferences/shared_preferences.dart';
import 'landing_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () async {
      final prefs = await SharedPreferences.getInstance();
      final hasSeenLandingPage = prefs.getBool('hasSeenLandingPage') ?? false;

      if (!hasSeenLandingPage) {
        _navigateWithFade(const LandingPage());
      } else {
        //LandingPage() will be replaced later on with an Auth() or Wrapper()
        //User go directly to the Auth page if he has seen landing before.
        _navigateWithFade(const LandingPage());
      }
    });
  }

  void _navigateWithFade(Widget destination) {
    Navigator.of(context).pushReplacement(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) => destination,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          return FadeTransition(
            opacity: animation,
            child: child,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final themeColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Image.asset(
              'assets/logo/co2_logo.png',
              width: 350, // Adjust width and height as needed.
              height: 250,
              fit: BoxFit.contain, // Ensures the image maintains aspect ratio.
            ),
          ),
          const SizedBox(height: 20),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: SpinKitThreeBounce(
                color: themeColor, // Same color as the text
                size: 30.0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
