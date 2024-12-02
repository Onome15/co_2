import 'package:flutter/material.dart';
import 'package:co_2/screens/authenticate/otp_verification.dart';
import 'package:co_2/screens/authenticate/shared_authentication_methods.dart';
import '../../shared/methods.dart';
import 'register.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isSignInWithEmail = true; // Toggles between mobile and email sign-in
  final _emailFormKey = GlobalKey<FormState>();
  final _mobileFormKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              headerImage(context, 'assets/images/login_image.jpg'),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Login",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    const Text(
                      "Welcome, Kindly Login using your mobile number or email address, An OTP will be sent to you for confirmation.",
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),

                    // Toggle button
                    TextButton(
                      onPressed: () {
                        setState(() {
                          _isSignInWithEmail = !_isSignInWithEmail;
                        });
                      },
                      style: TextButton.styleFrom(
                        overlayColor: Colors.transparent,
                      ),
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: Text(
                          _isSignInWithEmail
                              ? "Login with Email Address instead?"
                              : "Login with Mobile Number instead?",
                        ),
                      ),
                    ),
                    _isSignInWithEmail
                        ? _buildMobileSignInForm()
                        : _buildEmailSignInForm(),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          bool isValid = _isSignInWithEmail
                              ? _mobileFormKey.currentState!.validate()
                              : _emailFormKey.currentState!.validate();

                          if (isValid) {
                            String input = _isSignInWithEmail
                                ? mobileNumberController.text
                                : emailController.text;
                            navigateWithFade(
                              context,
                              OtpVerification(
                                  userDetail: input, isNewUser: false),
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(7),
                          ),
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 20),
                          backgroundColor: Colors.blue,
                        ),
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 10),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () =>
                              navigateWithFade(context, RegisterScreen()),
                          style: TextButton.styleFrom(
                            overlayColor: Colors.transparent,
                          ),
                          child: const Text("Register"),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Email sign-in form
  Widget _buildEmailSignInForm() {
    return Form(
      key: _emailFormKey,
      child: TextFormField(
        controller: emailController,
        decoration: textInputDecoration.copyWith(
          prefixIcon: const Icon(Icons.email),
          hintText: 'Enter your email address',
          labelText: 'Email',
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your email';
          }
          return null;
        },
      ),
    );
  }

  // Mobile sign-in form
  Widget _buildMobileSignInForm() {
    return Form(
      key: _mobileFormKey,
      child: TextFormField(
        controller: mobileNumberController,
        decoration: textInputDecoration.copyWith(
          prefixIcon: const Icon(Icons.phone_android),
          hintText: 'Enter your mobile number',
          labelText: 'Mobile Number',
        ),
        keyboardType: TextInputType.phone,
        maxLength: 11,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter your mobile number';
          }
          return null;
        },
      ),
    );
  }
}
