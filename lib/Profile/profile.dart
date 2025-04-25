
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:profile_screen/Achievements/add_achievement.dart';
import 'package:profile_screen/History/history.dart';
import 'package:profile_screen/Messages/messages.dart';
import 'package:profile_screen/Achievements/achievements.dart';
import 'package:profile_screen/Notifications/notifications.dart';
import 'package:profile_screen/Posts/add_post.dart';
import 'package:profile_screen/Posts/post_list.dart';
import 'package:profile_screen/Posts/posts.dart';
import 'package:profile_screen/Profile/chips.dart';
import 'package:profile_screen/Profile/fun_facts.dart';
import 'package:profile_screen/Profile/progress_bar.dart';
import 'package:profile_screen/Profile/update_profile.dart';
import 'package:profile_screen/Work/add_work.dart';
import 'package:profile_screen/Work/work.dart';
import 'package:profile_screen/Stats/stats.dart';
import 'package:provider/provider.dart';
import '../Mode/mode.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  ProfileScreenState createState() => ProfileScreenState();
}

class ProfileScreenState extends State<ProfileScreen> {
  //User profile information default values
  String firstName = 'Kabelo';
  String lastName = 'Makhanya';
  String bio = 'Hi, my name is Kabelo and I love builidng apps!';
  String profilePicture = 'assets/me.png';

  // Map interests to corresponding icons
  Map<String, IconData> interestIcons = {
    'Coding': Icons.code,
    'Photography': Icons.camera_alt,
    'Traveling': Icons.flight_takeoff,
    'Gaming': Icons.videogame_asset,
    'Music': Icons.music_note,
  };

// List of interests
  List<String> interests = [
    'Coding',
    'Photography',
    'Traveling',
    'Gaming',
    'Music',
  ];

  List<Map<String, dynamic>> posts = PostList().posts;

// Adds a new post to the list of posts
  void addNewPost(Map<String, dynamic> newPost) {
    setState(() {
      posts.add(newPost);
    });
  }

// Updates the profile information
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
              // Navigate to the update profile screen
              // Pass the current profile information to the screen
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
          // IconButton to toggle between light and dark mode
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
      // Bottom navigation bar for the dashboard, messages, notifications, and history
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatsScreen()),
                );
              },
              icon: Icon(Icons.analytics_outlined, size: 40),
            ),
            SizedBox(width: 30),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MessagesScreen()),
                );
              },
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.message, size: 40),
                  Positioned(
                    right: -5,
                    top: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '5', // Notification count
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 30),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Notifications()),
                );
              },
              icon: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(Icons.notifications_active, size: 40),
                  Positioned(
                    right: 0,
                    top: 0,
                    child: CircleAvatar(
                      radius: 10,
                      backgroundColor: Colors.red,
                      child: Text(
                        '12', // Notification count
                        style: TextStyle(fontSize: 12, color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: 20,),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => History()),
                );
              },
              icon: Icon(Icons.history, size: 40),
            ),
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
                // Profile picture, name, bio and profile stats
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
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '1.2K Followers',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('|'),
                    ),
                    Text(
                      '267 Likes',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('|'),
                    ),
                    Text(
                      '980 Following',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
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
                // Carousel slider for interests
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
                // Posts section
                SizedBox(
                  height: 500,
                  child: Stack(
                    children: [
                      Transform.translate(
                        offset: Offset(40, 20),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      // Dialog to add a new post
                                      IconButton(
                                        onPressed: () {
                                          setState(() {
                                            showDialog(
                                              context: context,
                                              builder:
                                                  (context) => AddPostDialog(),
                                            );
                                          });
                                        },
                                        icon: Icon(
                                          Icons.add_circle_outline,
                                          color:
                                              modeController.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                PostsCarousel(), // Carousel for posts
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                // Work experience section
                SizedBox(
                  height: 500,
                  child: Stack(
                    children: [
                      Transform.translate(
                        offset: Offset(-40, 20),
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
                                  padding: EdgeInsets.only(
                                    left: 25,
                                    top: 8,
                                    bottom: 8,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      // Dialog to add a new work experience
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (context) =>
                                                    const AddWorkDialog(),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.add_circle_outline,
                                          color:
                                              modeController.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                WorkCarousel(), // Carousel for work experience
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                // Achievements section
                SizedBox(
                  height: 500,
                  child: Stack(
                    children: [
                      Transform.translate(
                        offset: Offset(40, 20),
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
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
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
                                      // Dialog to add a new achievement
                                      IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (context) =>
                                                    const AddAchievementDialog(),
                                          );
                                        },
                                        icon: Icon(
                                          Icons.add_circle_outline,
                                          color:
                                              modeController.isDarkMode
                                                  ? Colors.white
                                                  : Colors.black,
                                          size: 30,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                AchievementCarousel(), // Carousel for achievements
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 60),
                // Skills section
                Text(
                  'Top skills',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color:
                        modeController.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                SkillsChips(),
                SizedBox(height: 20),
                // Fun facts section
                FunFactsSection(),
                SizedBox(height: 20),
                // Goal progress bar section
                Text(
                  'GOAL:',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color:
                        modeController.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                Text(
                  'BItcube mobile developer internship',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color:
                        modeController.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
                SizedBox(height: 20),
                ProgressBar(initialProgress: 0.3),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
