import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:profile_screen/Profile/update_profile.dart';
import 'package:provider/provider.dart';
import '../Mode/mode.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  String firstName = 'Kabelo';
  String lastName = 'Makhanya';
  String bio = 'I am a software developer.';
  String profilePicture = 'assets/me.png';
  List<String> interests = [
    'Coding',
    'Photography',
    'Traveling',
    'Gaming',
    'Music',
  ];

  void updateProfile(String updatedFirstName, String updatedLastName, String updatedBio,
      String updatedProfilePicture, List<String> updatedInterests) {
    setState(() {
      firstName = updatedFirstName;
      lastName = updatedLastName;
      bio = updatedBio;
      profilePicture = updatedProfilePicture;
      interests = updatedInterests;
    });
  }

  @override
  Widget build(BuildContext context) {
    final modeController = Provider.of<ModeController>(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UpdateProfileScreen(
                  profile: Profile(
                    firstName: firstName,
                    lastName: lastName,
                    bio: bio,
                    profilePicture: profilePicture,
                    interests: interests,
                  ),
                  onUpdate: updateProfile,
                ),
              ),
            );
          },
          icon: Icon(Icons.edit),
        ),
        title: Text('Profile'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              modeController.toggleMode();
            },
            icon: Icon(modeController.isDarkMode ? Icons.light_mode : Icons.dark_mode),
          ),
        ],
      ),
      body: Container(
        color: modeController.isDarkMode ? Colors.black : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: profilePicture.startsWith('assets/')
                    ? AssetImage(profilePicture) as ImageProvider
                    : FileImage(File(profilePicture)),
              ),
              SizedBox(height: 16),
              Text(
                '$firstName $lastName',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: modeController.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                bio,
                style: TextStyle(
                  fontSize: 16,
                  color: modeController.isDarkMode ? Colors.white70 : Colors.black87,
                ),
              ),
              SizedBox(height: 16),
              const Divider(
                color: Colors.grey,
                thickness: 1,
              ),
              SizedBox(height: 16),
              Text(
                'Interests',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: modeController.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
              SizedBox(height: 16),
              CarouselSlider(
                options: CarouselOptions(
                  height: 100,
                  autoPlay: true,
                  enlargeCenterPage: true,
                  enableInfiniteScroll: true,
                ),
                items: interests.map((interest) {
                  return Builder(
                    builder: (BuildContext context) {
                      return Container(
                        width: MediaQuery.of(context).size.width * 0.8,
                        margin: EdgeInsets.symmetric(horizontal: 8.0),
                        decoration: BoxDecoration(
                          color: Colors.blueAccent,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Text(
                            interest,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                }).toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
