import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:profile_screen/Profile/achievements.dart';
import 'package:profile_screen/Profile/posts.dart';
import 'package:profile_screen/Profile/update_profile.dart';
import 'package:profile_screen/Profile/work.dart';
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

  // Map interests to corresponding icons
  Map<String, IconData> interestIcons = {
    'Coding': Icons.code,
    'Photography': Icons.camera_alt,
    'Traveling': Icons.flight_takeoff,
    'Gaming': Icons.videogame_asset,
    'Music': Icons.music_note,
  };

  List<String> interests = [
    'Coding',
    'Photography',
    'Traveling',
    'Gaming',
    'Music',
  ];

  void updateProfile(
    String updatedFirstName,
    String updatedLastName,
    String updatedBio,
    String updatedProfilePicture,
    List<String> updatedInterests,
    Map<String, IconData> updatedInterestIcons,
  ) {
    setState(() {
      // Update only the fields that are being modified
      firstName = updatedFirstName;
      lastName = updatedLastName;
      bio = updatedBio;
      profilePicture = updatedProfilePicture;

      // Add new interests to the list
      for (var interest in updatedInterests) {
        if (!interests.contains(interest)) {
          interests.add(interest);
        }
      }

      // Add new icons for the updated interests
      updatedInterestIcons.forEach((key, value) {
        if (!interestIcons.containsKey(key)) {
          interestIcons[key] = value;
        }
      });
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
                builder:
                    (context) => UpdateProfileScreen(
                      profile: Profile(
                        firstName: firstName,
                        lastName: lastName,
                        bio: bio,
                        profilePicture: profilePicture,
                        interests: interestIcons.keys.toList(),
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
            icon: Icon(
              modeController.isDarkMode ? Icons.light_mode : Icons.dark_mode,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.analytics_outlined, size: 40,)),
            SizedBox(width: 30,),
            IconButton(onPressed: (){}, icon: Icon(Icons.notifications_active, size: 40,)),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          color: modeController.isDarkMode ? Colors.black : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      profilePicture.startsWith('assets/')
                          ? AssetImage(profilePicture) as ImageProvider
                          : FileImage(File(profilePicture)),
                ),
                SizedBox(height: 16),
                Text(
                  '$firstName $lastName',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color:
                        modeController.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  bio,
                  style: TextStyle(
                    fontSize: 16,
                    color:
                        modeController.isDarkMode
                            ? Colors.white70
                            : Colors.black87,
                  ),
                ),
                SizedBox(height: 16),
                const Divider(color: Colors.grey, thickness: 1),
                SizedBox(height: 16),
                Text(
                  'Interests',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color:
                        modeController.isDarkMode ? Colors.white : Colors.black,
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
                  items:
                      interestIcons.entries.map((entry) {
                        final interest = entry.key;
                        final icon = entry.value;
        
                        return Builder(
                          builder: (context) {
                            return Container(
                              width: MediaQuery.of(context).size.width * 0.8,
                              margin: EdgeInsets.symmetric(horizontal: 8.0),
                              decoration: BoxDecoration(
                                color:
                                    modeController.isDarkMode
                                        ? Colors.grey[800]!.withAlpha(100)
                                        : Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    icon,
                                    size: 40,
                                    color:
                                        modeController.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                  SizedBox(width: 16),
                                  Text(
                                    interest,
                                    style: TextStyle(
                                      fontSize: 20,
                                      color:
                                          modeController.isDarkMode
                                              ? Colors.white
                                              : Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        );
                      }).toList(),
                ),
                SizedBox(height: 16), 
                SizedBox(
                  height: 500,
                  child: Stack(
                    children: [
                      Transform.translate(
                        offset: Offset(10, 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                modeController.isDarkMode
                                    ? Colors.grey[800]!.withAlpha(100)
                                    : Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomLeft: Radius.circular(40),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Posts',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              modeController.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      IconButton(onPressed: (){
        
                                      }, icon: Icon(Icons.add_circle_outline,
                                        color: modeController.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                            size: 30,
                                      ),),
                                    ],
                                  ),
                                ),
                                PostsCarousel(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                SizedBox(
                  height: 500,
                  child: Stack(
                    children: [
                      Transform.translate(
                        offset: Offset(0, 25),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                modeController.isDarkMode
                                    ? Colors.grey[800]!.withAlpha(100)
                                    : Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topRight: Radius.circular(40),
                              bottomRight: Radius.circular(40),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Work experience',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              modeController.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      IconButton(onPressed: (){
        
                                      }, icon: Icon(Icons.add_circle_outline,
                                        color: modeController.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                            size: 30,
                                      ),),
                                    ],
                                  ),
                                ),
                                WorkCarousel(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60,),
                SizedBox(
                  height: 500,
                  child: Stack(
                    children: [
                      Transform.translate(
                        offset: Offset(10, 30),
                        child: Container(
                          decoration: BoxDecoration(
                            color:
                                modeController.isDarkMode
                                    ? Colors.grey[800]!.withAlpha(100)
                                    : Colors.grey[200],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              bottomLeft: Radius.circular(40),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Achievements',
                                        style: TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              modeController.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                        ),
                                      ),
                                      IconButton(onPressed: (){
        
                                      }, icon: Icon(Icons.add_circle_outline,
                                        color: modeController.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                            size: 30,
                                      ),),
                                    ],
                                  ),
                                ),
                                AchievementCarousel(),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
