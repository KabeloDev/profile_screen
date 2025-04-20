import 'package:flutter/material.dart';

class Profile {
  String firstName;
  String lastName;
  String bio;
  String profilePicture;
  Map<String, IconData> interestIcons;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.profilePicture,
    required this.interestIcons,
  });
}
