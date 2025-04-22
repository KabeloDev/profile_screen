import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:profile_screen/Mode/mode.dart';
import 'package:provider/provider.dart';

class AchievementCarousel extends StatefulWidget {
  const AchievementCarousel({super.key});

  @override
  State<AchievementCarousel> createState() => _AchievementCarouselState();
}

class _AchievementCarouselState extends State<AchievementCarousel> {
  final List<Map<String, String>> achievements = [
  {
    'title': 'Matriculated with Distinction',
    'content': 'Top 10 academic performer in final year.',
    'image': 'assets/achievement.jpg',
    'date': 'Dec 2019',
  },
  {
    'title': 'Diploma in IT Completed',
    'content': 'Graduated with solid project work and leadership in group assignments.',
    'image': 'assets/achievement.jpg',
    'date': 'Nov 2023',
  },
  {
    'title': 'Internship Project Deployed',
    'content': 'Contributed to a live feature during my dev internship.',
    'image': 'assets/achievement.jpg',
    'date': 'Mar 2024',
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
            achievements.map((achievement) {
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
                            achievement['image']!,
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
                                achievement['title']!,
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(height: 5),
                              Text(
                                achievement['content']!,
                                style: TextStyle(fontSize: 14),
                              ),
                               SizedBox(height: 5),
                              Text(
                                achievement['date']!,
                                style: TextStyle(fontSize: 14),
                              ),
                              SizedBox(height: 5),
                              Row(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                    },
                                    icon: Icon(Icons.edit),
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
