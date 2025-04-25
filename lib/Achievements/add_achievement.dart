import 'package:flutter/material.dart';
import 'package:profile_screen/Achievements/achievement_list.dart';
import 'package:provider/provider.dart';

class AddAchievementDialog extends StatefulWidget {
  const AddAchievementDialog({super.key});

  @override
  State<AddAchievementDialog> createState() => _AddAchievementDialogState();
}

class _AddAchievementDialogState extends State<AddAchievementDialog> {
  // Controllers for the input fields
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    // Dispose of controllers to free up resources
    titleController.dispose();
    descriptionController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Achievement'), 
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Input field for the achievement title
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Achievement Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Input field for the achievement description
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3, 
            ),
            const SizedBox(height: 10),
            // Input field for the achievement date
            TextField(
              controller: dateController,
              decoration: const InputDecoration(
                labelText: 'Date',
                border: OutlineInputBorder(),
              ),
              keyboardType: TextInputType.datetime, 
            ),
          ],
        ),
      ),
      actions: [
        // Cancel button to close the dialog without saving
        TextButton(
          onPressed: () {
            Navigator.pop(context); 
          },
          child: const Text('Cancel'),
        ),
        // Add button to save the new achievement
        TextButton(
          onPressed: () {
            // Ensure all fields are filled before adding the achievement
            if (titleController.text.isNotEmpty &&
                descriptionController.text.isNotEmpty &&
                dateController.text.isNotEmpty) {
              final newAchievement = {
                'title': titleController.text,
                'content': descriptionController.text,
                'date': dateController.text,
              };

              // Add the new achievement to the list and notify listeners
              final achievementList =
                  Provider.of<AchievementList>(context, listen: false);
              achievementList.addAchievement(newAchievement);

              // Show a success message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Achievement added successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );

              Navigator.pop(context); 
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}
