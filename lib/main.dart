import 'package:flutter/material.dart';
import 'package:flutternotepad/Colors/colors.dart';
import 'package:flutternotepad/Screens/homescreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundclr,
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}
