import 'package:co_2/screens/authenticate/register.dart';
import 'package:co_2/screens/authenticate/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  Future<void> _navigateWithFade(
      BuildContext context, Widget destination) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('hasSeenLandingPage', true);

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
    final accentColor = Theme.of(context).colorScheme.primary;
    final surface = Theme.of(context).colorScheme.surface;

    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  'assets/logo/co2_logo.png',
                  width: 300, // Adjust width and height as needed.
                  height: 200,
                  fit: BoxFit
                      .contain, // Ensures the image maintains aspect ratio.
                ),

                SvgPicture.asset(
                  "assets/vectors/invest_vector.svg",
                  // colorFilter: ColorFilter.mode(accentColor, BlendMode.srcIn),
                  height: 250,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Dream. Invest. Live",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w900,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                const Text(
                  "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        _navigateWithFade(context, RegisterScreen()),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      backgroundColor: accentColor,
                    ),
                    child: Text("Create an account",
                        style: TextStyle(
                            color: surface, fontWeight: FontWeight.bold)),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () =>
                        _navigateWithFade(context, const LoginScreen()),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: accentColor),
                      padding: const EdgeInsets.symmetric(vertical: 15),
                    ),
                    child: Text(
                      "Already have an account",
                      style: TextStyle(
                          color: accentColor, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextButton(
                    onPressed: () {},
                    child:
                        const Text("Continue as a guest?")) //Anonymous Sign In
              ],
            ),
          ),
        ),
      ),
    );
  }
}
