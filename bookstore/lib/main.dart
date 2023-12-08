import 'package:bookstore/common/values/colors.dart';
import 'package:bookstore/onboarding/screen/onboarding_screen.dart';
import 'package:bookstore/user/main_tab/main_tab_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Store',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primaryColor: AppColors.primaryColor,
       fontFamily: 'SF Pro Text'
      ),
      home: const OnboardingScreen(),
      // home: MainTabScreen(),
    );
  }
}
