import 'package:flutter/material.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  final List<Map<String, dynamic>> activities = [
    {
      'icon': Icons.history,
      'title': 'Posted a new update',
      'description': 'Shared a post about Flutter development.',
      'timestamp': 'April 23, 2025, 10:30 AM',
    },
    {
      'icon': Icons.history,
      'title': 'Commented on a post',
      'description': 'Commented: "Great post! Very informative."',
      'timestamp': 'April 22, 2025, 5:45 PM',
    },
    {
      'icon': Icons.history,
      'title': 'Updated profile picture',
      'description': 'Changed profile picture.',
      'timestamp': 'April 21, 2025, 8:15 AM',
    },
    {
      'icon': Icons.history,
      'title': 'Achieved a milestone',
      'description': 'Completed the "Bitcube Developer Challenge".',
      'timestamp': 'April 20, 2025, 3:00 PM',
    },
    {
      'icon': Icons.history,
      'title': 'Logged in',
      'description': 'Logged into the app.',
      'timestamp': 'April 19, 2025, 9:00 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Activity History'), centerTitle: true),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                activities.isNotEmpty
                    ? 'Recent Activities'
                    : 'No Activities Yet',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: activities.length,
                itemBuilder: (context, index) {
                  final activity = activities[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(
                        activity['icon'],
                        color: Colors.blue,
                        size: 30,
                      ),
                      title: Text(
                        activity['title'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(activity['description']),
                          const SizedBox(height: 4),
                          Text(
                            activity['timestamp'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                      trailing: IconButton(
                        onPressed: () {
                          setState(() {
                            activities.removeAt(index);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Text('Activity deleted'),
                                duration: const Duration(seconds: 2),
                              ),
                            );
                          });
                        },
                        icon: Icon(Icons.delete),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
