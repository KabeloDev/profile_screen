import 'package:flutter/material.dart';

class AchievementList extends ChangeNotifier {
  // List of achievements with details like title, content, image, and date

  final List<Map<String, String>> _achievements = [
    {
      'title': 'Matriculated with Distinction',
      'content': 'Top 10 academic performer in final year.',
      'image': 'assets/achievement.jpg',
      'date': 'Dec 2019',
    },
    {
      'title': 'Diploma in IT Completed',
      'content':
          'Graduated with solid project work and leadership in group assignments.',
      'image': 'assets/achievement.jpg',
      'date': 'Nov 2023',
    },
    {
      'title': 'Internship Project Deployed',
      'content': 'Contributed to a live feature during my dev internship.',
      'image': 'assets/achievement.jpg',
      'date': 'Mar 2024',
    },
  ];

  // Getter to retrieve the list of achievements
  List<Map<String, String>> get achievement => _achievements;

  // Adds a new achievement to the list and notifies listeners to update the UI
  void addAchievement(Map<String, String> newAchievement) {
    _achievements.add(newAchievement);
    notifyListeners();
  }
}
