import 'package:flutter/material.dart';

class WorkList extends ChangeNotifier {
   final List<Map<String, String>> _work = [
  {
    'title': 'Software Development Intern',
    'content': 'Built features using ASP.NET Core & Flutter.',
    'image': 'assets/work.jpg',
    'date': 'Jan 2024 – Mar 2024',
  },
  {
    'title': 'Freelance Web Developer',
    'content': 'Created websites for small businesses.',
    'image': 'assets/work.jpg',
    'date': 'Jul 2023 – Dec 2023',
  },
  {
    'title': 'IT Support Assistant',
    'content': 'Handled technical issues & user support.',
    'image': 'assets/work.jpg',
    'date': 'Jan 2023 – Jun 2023',
  },
];

  List<Map<String, String>> get work => _work;

  void addWork(Map<String, String> newWork) {
    _work.add(newWork);
    notifyListeners();
  }
}
