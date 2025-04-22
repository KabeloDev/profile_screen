import 'package:flutter/material.dart';
import 'package:profile_screen/Work/work_list.dart';
import 'package:provider/provider.dart';


class AddWorkDialog extends StatefulWidget {
  const AddWorkDialog({super.key});

  @override
  State<AddWorkDialog> createState() => _AddWorkDialogState();
}

class _AddWorkDialogState extends State<AddWorkDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  final TextEditingController dateController = TextEditingController();

  @override
  void dispose() {
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
          TextField(
            controller: titleController,
            decoration: const InputDecoration(
              labelText: 'Job Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 10),
          TextField(
            controller: contentController,
            decoration: const InputDecoration(
              labelText: 'Job Description',
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
            keyboardType: TextInputType.datetime,
          ),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: const Text('Cancel'),
      ),
      TextButton(
        onPressed: () {
          if (titleController.text.isNotEmpty &&
              contentController.text.isNotEmpty &&
              dateController.text.isNotEmpty) {
            final newWork = {
              'title': titleController.text,
              'content': contentController.text,
              'date': dateController.text,
            };

            final workList = Provider.of<WorkList>(context, listen: false);
            workList.addWork(newWork);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Work experience added successfully!'),
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