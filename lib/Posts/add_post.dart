import 'package:flutter/material.dart';
import 'package:profile_screen/Posts/post_list.dart';
import 'package:provider/provider.dart';

class AddPostDialog extends StatefulWidget {
  const AddPostDialog({super.key});

  @override
  State<AddPostDialog> createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  // Controllers for the input fields
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  String? selectedImage; // Stores the selected image for the post

  // List of predefined images for selection
  final List<String> predefinedImages = [
    'assets/post4.jpeg',
    'assets/post5.jpg',
    'assets/post6.jpg',
    'assets/post7.jpg',
    'assets/post8.jpeg',
    'assets/post9.jpg',
  ];

  @override
  void dispose() {
    // Dispose of controllers to free up resources
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Post'), 
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Input field for the post title
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Post Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            // Input field for the post content
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Post Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 3, 
            ),
            const SizedBox(height: 10),
            const Text('Select an Image'), // Section title for image selection
            const SizedBox(height: 10),
            // Display predefined images for selection
            Wrap(
              spacing: 8.0,
              children: predefinedImages.map((imagePath) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedImage = imagePath; // Update the selected image
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: selectedImage == imagePath
                            ? Colors.blue // Highlight the selected image
                            : Colors.transparent,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Image.asset(
                      imagePath,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
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
        // Post button to save the new post
        TextButton(
          onPressed: () {
            // Ensure all fields are filled before adding the post
            if (titleController.text.isNotEmpty &&
                contentController.text.isNotEmpty &&
                selectedImage != null) {
              final newPost = {
                'title': titleController.text,
                'content': contentController.text,
                'image': selectedImage,
                'likes': 0,
                'comments': 0,
                'commentList': [],
              };

              // Access the PostList via Provider and add the new post
              final postList = Provider.of<PostList>(context, listen: false);
              postList.addPost(newPost);

              // Show a success message
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Post added successfully!'),
                  duration: Duration(seconds: 2),
                ),
              );

              Navigator.pop(context); // Dismiss the dialog
            }
          },
          child: const Text('Post'),
        ),
      ],
    );
  }
}
