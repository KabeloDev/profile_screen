import 'package:flutter/material.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // List of messages with sender, content, and timestamp
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
        title: const Text('Messages'),
        centerTitle: true, 
      ),
      body: ListView.builder(
        itemCount: messages.length, 
        itemBuilder: (context, index) {
          final message = messages[index];
          return ListTile(
            leading: const CircleAvatar(
              child: Icon(Icons.person), // Placeholder for sender's avatar
            ),
            title: Text(message['sender']!), // Sender's name
            subtitle: Text(message['message']!), // Message content
            trailing: Text(message['time']!), // Timestamp of the message
            onTap: () {
              // Open a detailed view of the message in a bottom modal sheet
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                builder: (context) {
                  return DraggableScrollableSheet(
                    expand: false,
                    initialChildSize: 0.9, // Initial height of the modal
                    maxChildSize: 1.0, // Maximum height of the modal
                    minChildSize: 0.5, // Minimum height of the modal
                    builder: (context, scrollController) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header with sender's name and action buttons
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  message['sender']!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    // Placeholder for video call action
                                  },
                                  icon: const Icon(Icons.call),
                                ),
                              ],
                            ),
                            const Divider(),
                            const SizedBox(height: 10),
                            // Message content displayed 
                            Expanded(
                              child: SingleChildScrollView(
                                controller: scrollController,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: Colors.blue, // Message bubble color
                                      ),
                                      child: Padding(
                                        padding: const EdgeInsets.all(10),
                                        child: Text(
                                          message['message']!,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 5),
                                    Text(
                                      message['time']!,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            // Input field for sending a reply
                            TextField(
                              decoration: InputDecoration(
                                labelText: 'Type a message...',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                prefixIcon: IconButton(
                                  onPressed: () {
                                    // Placeholder for emoji picker
                                  },
                                  icon: const Icon(Icons.emoji_emotions),
                                ),
                                suffixIcon: IconButton(
                                  icon: const Icon(Icons.send),
                                  onPressed: () {
                                    // Placeholder for sending a message
                                  },
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
