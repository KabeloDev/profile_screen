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
        ChangeNotifierProvider(create: (context) => ModeController()),  
        ChangeNotifierProvider(create: (context) => PostList()),  
        ChangeNotifierProvider(create: (context) => WorkList()), 
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
    final modeController = Provider.of<ModeController>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: modeController.isDarkMode ? Brightness.dark : Brightness.light,
      ),
      home: SplashScreen(),
    );
  }
}

