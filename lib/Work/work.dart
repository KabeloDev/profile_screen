import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:profile_screen/Mode/mode.dart';
import 'package:profile_screen/Work/work_list.dart';
import 'package:provider/provider.dart';

class WorkCarousel extends StatefulWidget {
  const WorkCarousel({super.key});

  @override
  State<WorkCarousel> createState() => _WorkCarouselState();
}

class _WorkCarouselState extends State<WorkCarousel> {
  // Opens a dialog to edit the selected work experience
  void showEditWorkDialog(Map<String, dynamic> work) {
    final TextEditingController titleController = TextEditingController(text: work['title']);
    final TextEditingController contentController = TextEditingController(text: work['content']);
    final TextEditingController dateController = TextEditingController(text: work['date']);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Edit Work Experience'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
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
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog without saving
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  // Update the work experience with new values
                  work['title'] = titleController.text;
                  work['content'] = contentController.text;
                  work['date'] = dateController.text;
                });
                Navigator.pop(context); // Close the dialog
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Work experience updated successfully!'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  // Deletes the selected work experience and shows a confirmation message
  void deleteWorkExperience(Map<String, dynamic> work) {
    setState(() {
      final workList = Provider.of<WorkList>(context, listen: false);
      workList.work.remove(work); // Remove the work experience from the list
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Work experience deleted successfully!'),
          duration: Duration(seconds: 2),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final modeController = Provider.of<ModeController>(context);
    final workList = Provider.of<WorkList>(context); // Access the WorkList from the provider
    final work = workList.work;

    return CarouselSlider(
      options: CarouselOptions(
        height: 400.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
      ),
      items: work.map((work) {
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
                  // Display the work image at the top of the card
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(15.0),
                    ),
                    child: Image.asset(
                      'assets/work.jpg', 
                      height: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5, right: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Display the work title
                        Text(
                          work['title']!,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        // Display the work content
                        Text(
                          work['content']!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        // Display the work date
                        Text(
                          work['date']!,
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        // Action buttons for editing and deleting the work experience
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                showEditWorkDialog(work); // Open the edit dialog
                              },
                              icon: const Icon(Icons.edit),
                              color: modeController.isDarkMode ? Colors.white : Colors.black,
                            ),
                            const SizedBox(width: 20),
                            IconButton(
                              onPressed: () {
                                deleteWorkExperience(work); // Delete the work experience
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
