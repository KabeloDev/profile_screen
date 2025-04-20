import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> messages = [
      {
        'sender': 'John Doe',
        'message': 'Hey! Are we still on for the meeting tomorrow?',
        'time': '10:15 AM',
      },
      {
        'sender': 'Jane Smith',
        'message': 'Don’t forget to check out the new project updates.',
        'time': '9:45 AM',
      },
      {
        'sender': 'Mike Johnson',
        'message': 'Can you send me the files by EOD?',
        'time': '8:30 AM',
      },
      {
        'sender': 'Emily Davis',
        'message': 'Thanks for the help earlier. Really appreciate it!',
        'time': 'Yesterday',
      },
      {
        'sender': 'Sarah Wilson',
        'message': 'Let’s catch up soon. It’s been a while!',
        'time': 'Monday',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Messages'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return ListTile(
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            title: Text(message['sender']!),
            subtitle: Text(message['message']!),
            trailing: Text(message['time']!),
            onTap: () {
              // Handle message tap
            },
          );
        },
      ),
    );
  }
}