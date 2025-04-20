import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:profile_screen/Mode/mode.dart';
import 'package:provider/provider.dart';

class WorkCarousel extends StatefulWidget {
  const WorkCarousel({super.key});

  @override
  State<WorkCarousel> createState() => _WorkCarouselState();
}

class _WorkCarouselState extends State<WorkCarousel> {
  final List<Map<String, String>> work = [
  {
    'title': 'Software Development Intern',
    'content': 'Built features using ASP.NET Core & Flutter.',
    'image': 'assets/work.jpg',
    'date': 'Jan 2024 – Mar 2024',
  },
  {
    'title': 'Freelance Web Developer',
    'content': 'Created websites for small businesses.',
    'image': 'assets/work.jpg',
    'date': 'Jul 2023 – Dec 2023',
  },
  {
    'title': 'IT Support Assistant',
    'content': 'Handled technical issues & user support.',
    'image': 'assets/work.jpg',
    'date': 'Jan 2023 – Jun 2023',
  },
];




  @override
  Widget build(BuildContext context) {
    final modeController = Provider.of<ModeController>(context);

    return CarouselSlider(
        options: CarouselOptions(
          height: 400.0,
          enlargeCenterPage: true,
          enableInfiniteScroll: true,
        ),
        items:
            work.map((work) {
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
                            work['image']!,
                            height: 150,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            left: 5,
                            right: 5,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                work['title']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                work['content']!,
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Text(
                                work['date']!,
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 5),
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
                                  SizedBox(width: 20),
                                  IconButton(
                                    onPressed: () {},
                                    icon: Icon(Icons.delete),
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
      );  }
}
