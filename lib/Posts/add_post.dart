import 'package:flutter/material.dart';
import 'package:profile_screen/Posts/post_list.dart';
import 'package:provider/provider.dart';

class AddPostDialog extends StatefulWidget {
  const AddPostDialog({super.key});

  @override
  State<AddPostDialog> createState() => _AddPostDialogState();
}

class _AddPostDialogState extends State<AddPostDialog> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController contentController = TextEditingController();
  String? selectedImage;

  final List<String> predefinedImages = [
    'assets/post1.jpg',
    'assets/post2.jpg',
    'assets/post3.jpg',
  ];

  @override
  void dispose() {
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
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Post Title',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: contentController,
              decoration: const InputDecoration(
                labelText: 'Post Content',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 10),
            const Text('Select an Image'),
            const SizedBox(height: 10),
            Wrap(
              spacing: 8.0,
              children:
                  predefinedImages.map((imagePath) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedImage = imagePath;
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color:
                                selectedImage == imagePath
                                    ? Colors.blue
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
