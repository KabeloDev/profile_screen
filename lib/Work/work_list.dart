import 'package:flutter/material.dart';

class WorkList extends ChangeNotifier {
  // A list of work experiences, each represented as a map with details like title, content, image, and date
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

  // Getter to expose the list of work experiences
  List<Map<String, String>> get work => _work;

  // Adds a new work experience to the list and notifies listeners to update the UI
  void addWork(Map<String, String> newWork) {
    _work.add(newWork);
    notifyListeners(); // Notify listeners that the data has changed
  }
}
