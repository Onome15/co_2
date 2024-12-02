import 'package:flutter/material.dart';

headerImage(context, String path) {
  return Container(
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.width * 0.7,
    decoration: BoxDecoration(
      image: DecorationImage(
        image: AssetImage(path),
        fit: BoxFit.cover,
      ),
    ),
  );
}
