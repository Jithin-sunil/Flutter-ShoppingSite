import 'package:flutter/material.dart';
import 'package:userapp/mybooking.dart';
import 'package:userapp/rating.dart';

import 'package:userapp/splashscreen.dart';
import 'package:userapp/viewproduct.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home:ProductRatingPage()
    );
  }
}
