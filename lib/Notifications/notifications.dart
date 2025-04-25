import 'package:flutter/material.dart';

class Notifications extends StatelessWidget {
  Notifications({super.key});

  // List of notifications with details like title, description, timestamp, and icon
  final List<Map<String, dynamic>> notifications = [
    {
      'icon': Icons.notifications_active,
      'title': 'New Follower',
      'description': 'John Doe started following you.',
      'timestamp': 'April 23, 2025, 10:30 AM',
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Post Liked',
      'description': 'Jane Smith liked your post.',
      'timestamp': 'April 22, 2025, 5:45 PM',
    },
    {
      'icon': Icons.notifications_active,
      'title': 'New Comment',
      'description': 'Mike Johnson commented: "Great post!"',
      'timestamp': 'April 21, 2025, 8:15 AM',
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Profile Viewed',
      'description': 'Emily Davis viewed your profile.',
      'timestamp': 'April 20, 2025, 3:00 PM',
    },
    {
      'icon': Icons.notifications_active,
      'title': 'New Message',
      'description': 'Sarah Wilson sent you a message.',
      'timestamp': 'April 19, 2025, 9:00 AM',
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Milestone Achieved',
      'description': 'You completed the "Bitcube Developer Challenge".',
      'timestamp': 'April 18, 2025, 2:00 PM',
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Post Shared',
      'description': 'Your post was shared by Alex Brown.',
      'timestamp': 'April 17, 2025, 6:30 PM',
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Reminder',
      'description': 'Don’t forget to complete your profile setup.',
      'timestamp': 'April 16, 2025, 8:00 AM',
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Group Invitation',
      'description': 'You were invited to join the "Flutter Developers" group.',
      'timestamp': 'April 15, 2025, 4:45 PM',
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Event Reminder',
      'description': 'The "Flutter Workshop" starts tomorrow at 10:00 AM.',
      'timestamp': 'April 14, 2025, 7:00 PM',
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Profile Updated',
      'description': 'You updated your bio.',
      'timestamp': 'April 13, 2025, 11:30 AM',
    },
    {
      'icon': Icons.notifications_active,
      'title': 'Achievement Unlocked',
      'description': 'You unlocked the "Top Contributor" badge.',
      'timestamp': 'April 12, 2025, 9:15 AM',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true, 
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Recent Notifications',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              // List of notifications displayed as cards
              ListView.builder(
                shrinkWrap: true, // Prevents the list from expanding infinitely
                physics: const NeverScrollableScrollPhysics(), // Disables scrolling within the list
                itemCount: notifications.length,
                itemBuilder: (context, index) {
                  final notification = notifications[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Icon(
                        notification['icon'],
                        color: Colors.blue,
                        size: 30,
                      ),
                      title: Text(
                        notification['title'], 
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Notification description
                          Text(notification['description']),
                          const SizedBox(height: 4),
                          // Timestamp for the notification
                          Text(
                            notification['timestamp'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.grey,
                            ),
                          ),
                        ],
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
