import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Mode/mode.dart';
import 'Profile/profile.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ModeController(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final modeController = Provider.of<ModeController>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: modeController.isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: ProfileScreen(),
    );
  }
}

