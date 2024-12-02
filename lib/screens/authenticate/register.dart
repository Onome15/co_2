import 'package:co_2/screens/authenticate/otp_verification.dart';
import 'package:co_2/screens/authenticate/shared_authentication_methods.dart';
import 'package:co_2/screens/authenticate/login.dart';
import 'package:flutter/material.dart';
import '../../shared/methods.dart';

class RegisterScreen extends StatelessWidget {
  RegisterScreen({super.key});

  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController mobileNumberController = TextEditingController();

  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              headerImage(context, 'assets/images/register_image.jpg'),
              Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Register",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                    ),
                    const Text(
                      "Please create an account to continue using this app, \n An OTP will be sent to the number for confirmation",
                      textAlign: TextAlign.center,
                    ),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          TextFormField(
                            controller: nameController,
                            decoration: textInputDecoration.copyWith(
                              prefixIcon: const Icon(Icons.person),
                              hintText: 'Enter your name',
                              labelText: 'Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter your name';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),
                          TextFormField(
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
                          const SizedBox(height: 20),
                          TextFormField(
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
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          String mobileNumber = mobileNumberController.text;
                          if (_formKey.currentState!.validate()) {
                            navigateWithFade(
                              context,
                              OtpVerification(
                                userDetail: mobileNumber,
                                isNewUser: true,
                              ),
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
                          'Register',
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
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () =>
                              navigateWithFade(context, const LoginScreen()),
                          style: TextButton.styleFrom(
                            overlayColor: Colors.transparent,
                          ),
                          child: const Text("Login"),
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
}
