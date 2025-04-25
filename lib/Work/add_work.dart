import 'package:flutter/material.dart';
import 'package:profile_screen/Work/work_list.dart';
import 'package:provider/provider.dart';

class AddWorkDialog extends StatefulWidget {
  const AddWorkDialog({super.key});

  @override
  State<AddWorkDialog> createState() => _AddWorkDialogState();
}

class _AddWorkDialogState extends State<AddWorkDialog> {
  // Controllers for the input fields
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
    // Dispose of the controllers to free up resources
    titleController.dispose();
    contentController.dispose();
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Work Experience'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Input field for the job title
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Job Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Input field for the job description
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Job Description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            // Input field for the job date
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
        // Add button to save the new work experience
        TextButton(
          onPressed: () {
            // Ensure all fields are filled before proceeding
            if (titleController.text.isNotEmpty &&
                contentController.text.isNotEmpty &&
                dateController.text.isNotEmpty) {
              // Create a new work experience entry
              final newWork = {
                'title': titleController.text,
                'content': contentController.text,
                'date': dateController.text,
              };

              // Add the new work experience to the list and notify listeners
              final workList = Provider.of<WorkList>(context, listen: false);
              workList.addWork(newWork);

              // Show a confirmation message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Work experience added successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );

              // Close the dialog
              Navigator.pop(context);
            }
          },
          child: const Text('Add'),
        ),
      ],
    );
  }
}