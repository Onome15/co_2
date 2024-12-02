import 'package:flutter/material.dart';

Widget headerWithIcon({
  double fontSize = 30,
  double sizedBoxWidth = 5,
  double iconSize = 35,
}) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Image.asset(
        'assets/logo/co2_logo.png',
        width: fontSize,
        height: fontSize,
        fit: BoxFit.contain,
      ),
      SizedBox(width: sizedBoxWidth),
      Icon(
        Icons.menu_book_rounded,
        color: const Color(0xFF0057FF),
        size: iconSize,
      ),
    ],
  );
}

final textInputDecoration = InputDecoration(
  filled: true,
  contentPadding: const EdgeInsets.all(10.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(width: 2.0),
  ),
  focusedBorder: OutlineInputBorder(
    borderRadius: BorderRadius.circular(10),
    borderSide: const BorderSide(width: 2.0),
  ),
);

Future<void> navigateWithFade(BuildContext context, Widget destination) async {
  if (context.mounted) {
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
}
