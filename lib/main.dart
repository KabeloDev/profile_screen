import 'package:flutter/material.dart';
import 'package:profile_screen/Achievements/achievement_list.dart';
import 'package:profile_screen/Posts/post_list.dart';
import 'package:profile_screen/Splash/splash.dart';
import 'package:profile_screen/Work/work_list.dart';
import 'package:provider/provider.dart';
import 'Mode/mode.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        // Handles light/dark mode switching
        ChangeNotifierProvider(create: (context) => ModeController()),  

        // Manages the list of posts
        ChangeNotifierProvider(create: (context) => PostList()),  

        // Manages the list of work experiences
        ChangeNotifierProvider(create: (context) => WorkList()), 

        // Manages the list of achievements
        ChangeNotifierProvider(create: (context) => AchievementList()), 
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Access the mode controller to determine the app's theme
    final modeController = Provider.of<ModeController>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false, // Hides the debug banner in the app
      theme: ThemeData(
        // Dynamically applies light or dark theme based on user preference
        brightness: modeController.isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: SplashScreen(), // Splash screen displayed when the app starts
    );
  }
}

