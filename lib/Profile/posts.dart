import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:profile_screen/Mode/mode.dart';
import 'package:provider/provider.dart';

class PostsCarousel extends StatefulWidget {
  @override
  State<PostsCarousel> createState() => _PostsCarouselState();
}

class _PostsCarouselState extends State<PostsCarousel> {
  final List<Map<String, String>> posts = [
    {
      'title': 'Post 1',
      'content': 'This is the content of post 1.',
      'image': 'assets/default-profile.jpg',
    },
    {
      'title': 'Post 2',
      'content': 'This is the content of post 2.',
      'image': 'assets/default-profile.jpg',
    },
    {
      'title': 'Post 3',
      'content': 'This is the content of post 3.',
      'image': 'assets/default-profile.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    final modeController = Provider.of<ModeController>(context);

    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 350.0,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
        ),
        items:
            posts.map((post) {
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
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(15.0),
                          ),
                          child: Image.asset(
                            post['image']!,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                post['title']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                post['content']!,
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                    },
                                    icon: Icon(Icons.thumb_up),
                                    color:
                                        modeController.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                  SizedBox(width: 20),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.comment),
                                    color:
                                        modeController.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
                                  ),
                                  SizedBox(width: 20),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.share),
                                    color:
                                        modeController.isDarkMode
                                            ? Colors.white
                                            : Colors.black,
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
      ),
    );
  }
}
