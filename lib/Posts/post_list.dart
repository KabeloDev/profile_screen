import 'package:flutter/material.dart';

class PostList extends ChangeNotifier {
  final List<Map<String, dynamic>> _posts = [
    {
      'title': 'Walking my dog',
      'content': 'Enjoying the fresh air and some quality time with my furry buddy this morning.',
      'image': 'assets/post1.jpg',
      'likes': 25,
      'comments': 5,
      'commentList': ['Nice!', 'Looks fun!', 'Great picture!'],
    },
    {
      'title': 'At the park with my son',
      'content': 'Nothing beats watching him laugh and run around. Grateful for these little moments.',
      'image': 'assets/post2.jpg',
      'likes': 40,
      'comments': 8,
      'commentList': ['So cute!', 'Adorable!', 'Cherish these moments.'],
    },
    {
      'title': 'Soccer day',
      'content': 'Great match today with the squad. Legs are tired, but the spirit is high!',
      'image': 'assets/post3.jpg',
      'likes': 60,
      'comments': 12,
      'commentList': ['Well played!', 'Awesome!', 'Keep it up!'],
    },
  ];

  List<Map<String, dynamic>> get posts => _posts;

  void addPost(Map<String, dynamic> newPost) {
    _posts.add(newPost);
    notifyListeners();
  }
}
