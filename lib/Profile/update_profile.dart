import 'package:flutter/material.dart';

class Profile {
  String firstName;
  String lastName;
  String bio;

  Profile({required this.firstName, required this.lastName, required this.bio});
}

class UpdateProfileScreen extends StatefulWidget {
  final Profile profile;
  final Function(String, String, String) onUpdate;

  const UpdateProfileScreen({
    super.key,
    required this.profile,
    required this.onUpdate,
  });

  @override
  State<UpdateProfileScreen> createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  late TextEditingController firstNameController;
  late TextEditingController lastNameController;
  late TextEditingController bioController;

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.profile.firstName);
    lastNameController = TextEditingController(text: widget.profile.lastName);
    bioController = TextEditingController(text: widget.profile.bio);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Profile')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: bioController,
              decoration: InputDecoration(labelText: 'Bio'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                widget.onUpdate(
                  firstNameController.text,
                  lastNameController.text,
                  bioController.text,
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Profile updated successfully!', style: TextStyle(color: Colors.white),),
                    duration: Duration(seconds: 2),
                    backgroundColor: Colors.blueAccent, // You can change the color
                  ),
                );
              },
              child: Text('Save'),
            ),
          ],
        ),
      ),
    );
  }
}
