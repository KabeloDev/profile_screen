import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:profile_screen/Achievements/achievement_list.dart';
import 'package:profile_screen/Mode/mode.dart';
import 'package:provider/provider.dart';

class AchievementCarousel extends StatefulWidget {
  const AchievementCarousel({super.key});

  @override
  State<AchievementCarousel> createState() => _AchievementCarouselState();
}

class _AchievementCarouselState extends State<AchievementCarousel> {
  // Opens a dialog to edit an existing achievement
  void showEditAchievementDialog(Map<String, dynamic> achievement) {
    final TextEditingController titleController =
        TextEditingController(text: achievement['title']);
    final TextEditingController contentController =
        TextEditingController(text: achievement['content']);
    final TextEditingController dateController =
        TextEditingController(text: achievement['date']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Achievement'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Input fields for editing the achievement details
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Title',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: contentController,
                  decoration: const InputDecoration(
                    labelText: 'Content',
                    border: OutlineInputBorder(),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: dateController,
                  decoration: const InputDecoration(
                    labelText: 'Date',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            // Cancel button to close the dialog without saving changes
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancel'),
            ),
            // Save button to update the achievement details
            TextButton(
              onPressed: () {
                setState(() {
                  achievement['title'] = titleController.text;
                  achievement['content'] = contentController.text;
                  achievement['date'] = dateController.text;
                });
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Achievement updated successfully')),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Deletes an achievement from the list
  void deleteAchievement(Map<String, dynamic> achievement) {
    setState(() {
      final achievementList = Provider.of<AchievementList>(context, listen: false);
      achievementList.achievement.remove(achievement);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Achievement deleted successfully')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final modeController = Provider.of<ModeController>(context);
    final achievementList = Provider.of<AchievementList>(context); // Access the list of achievements
    final achievements = achievementList.achievement;

    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0, 
        enlargeCenterPage: true, 
        enableInfiniteScroll: true, 
      ),
      items: achievements.map((achievement) {
        return Builder(
          builder: (BuildContext context) {
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0), 
              ),
              elevation: 5, 
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15.0),
                    ),
                    child: Image.asset(
                      'assets/achievement.jpg',
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Achievement title
                        Text(
                          achievement['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Achievement content/description
                        Text(
                          achievement['content']!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        // Achievement date
                        Text(
                          achievement['date']!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        // Row of action buttons (edit and delete)
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showEditAchievementDialog(achievement); // Open the edit dialog
                              },
                              icon: const Icon(Icons.edit),
                              color: modeController.isDarkMode ? Colors.white : Colors.black,
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () {
                                deleteAchievement(achievement); // Delete the achievement
                              },
                              icon: const Icon(Icons.delete),
                              color: modeController.isDarkMode ? Colors.white : Colors.black,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
