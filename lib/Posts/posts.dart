import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:profile_screen/Mode/mode.dart';
import 'package:profile_screen/Posts/post_list.dart';
import 'package:provider/provider.dart';

class PostsCarousel extends StatefulWidget {
  const PostsCarousel({super.key});

  @override
  State<PostsCarousel> createState() => _PostsCarouselState();
}

class _PostsCarouselState extends State<PostsCarousel> {
 

  void showCommentsDialog(Map<String, dynamic> post) {
    final TextEditingController commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Comments'),
          content: SizedBox(
            width: double.maxFinite,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Flexible(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: (post['commentList'] ?? []).length,
                    itemBuilder: (context, index) {
                      final comment = post['commentList'][index].toString();
                      return ListTile(
                        title: Text(comment),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: commentController,
                  decoration: const InputDecoration(
                    labelText: 'Add a comment',
                    border: OutlineInputBorder(),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                final newComment = commentController.text.trim();
                if (newComment.isNotEmpty) {
                  if (mounted) {
                    setState(() {
                      post['commentList'] ??= [];
                      post['commentList'].add(newComment);
                      post['comments'] = (post['comments'] ?? 0) + 1;
                    });
                  }
                  commentController.clear();
                  Navigator.pop(context);
                }
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }

  void showShareDialog(BuildContext context, String postTitle) {
    final List<String> contacts = ['John Doe', 'Jane Smith', 'Mike Johnson', 'Emily Davis', 'Sarah Wilson'];

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Share Post'),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(contacts[index]),
                  onTap: () {
                    Navigator.pop(context); // Close the dialog
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Post "$postTitle" sent to ${contacts[index]}'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  

  @override
  Widget build(BuildContext context) {
    final modeController = Provider.of<ModeController>(context);
    final postList = Provider.of<PostList>(context);  // Access the PostList from the provider
    final posts = postList.posts;

    return CarouselSlider(
      options: CarouselOptions(
        height: 350.0,
        enlargeCenterPage: true,
        enableInfiniteScroll: true,
      ),
      items: posts.map((post) {
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
                      post['image'] ?? '',
                      height: 150,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 150,
                        color: Colors.grey,
                        child: const Center(child: Text('Image not found')),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          post['title'] ?? '',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          post['content'] ?? '',
                          style: const TextStyle(fontSize: 14),
                        ),
                        const SizedBox(height: 5),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  post['likes'] = (post['likes'] ?? 0) + 1;
                                });
                              },
                              icon: const Icon(Icons.thumb_up),
                              color: modeController.isDarkMode ? Colors.white : Colors.black,
                            ),
                            Text('${post['likes'] ?? 0}'),
                            const SizedBox(width: 5),
                            IconButton(
                              onPressed: () {
                                showCommentsDialog(post);
                              },
                              icon: const Icon(Icons.comment),
                              color: modeController.isDarkMode ? Colors.white : Colors.black,
                            ),
                            Text('${post['comments'] ?? 0}'),
                            const SizedBox(width: 5),
                            IconButton(
                              onPressed: () {
                                showShareDialog(context, post['title'] ?? '');
                              },
                              icon: const Icon(Icons.share),
                              color: modeController.isDarkMode ? Colors.white : Colors.black,
                            ),
                            const SizedBox(width: 5),
                            IconButton(
                              onPressed: () {
                                setState(() {
                                  posts.remove(post);
                                });
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
