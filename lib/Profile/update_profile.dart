import 'package:flutter/material.dart';

class Profile {
  String firstName;
  String lastName;
  String bio;
  String profilePicture;
  List<String> interests;

  Profile({
    required this.firstName,
    required this.lastName,
    required this.bio,
    required this.profilePicture,
    required this.interests,
  });
}

class UpdateProfileScreen extends StatefulWidget {
  final Profile profile;
  final Function(String, String, String, String, List<String>) onUpdate;
  

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
  late TextEditingController interestController;
  String? updatedProfilePicture;
  List<String> updatedInterests = [];
  final List<String> predefinedImages = [
    'assets/profile1.jpg',
    'assets/profile2.jpg',
    'assets/profile3.jpg',
    'assets/profile4.jpg',
    'assets/profile5.jpg',
    'assets/profile6.jpg',
  ];

  @override
  void initState() {
    super.initState();
    firstNameController = TextEditingController(text: widget.profile.firstName);
    lastNameController = TextEditingController(text: widget.profile.lastName);
    bioController = TextEditingController(text: widget.profile.bio);
    interestController = TextEditingController();
    updatedProfilePicture = widget.profile.profilePicture;
    updatedInterests = List.from(widget.profile.interests);
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    bioController.dispose();
    interestController.dispose();
    super.dispose();
  }

  void selectProfilePicture(String imagePath) {
    setState(() {
      updatedProfilePicture = imagePath;
    });
  }

  void addInterest(String interest) {
    if (!updatedInterests.contains(interest)) {
      setState(() {
        updatedInterests.add(interest);
      });
    }
  }

  void removeInterest(String interest) {
    setState(() {
      updatedInterests.remove(interest);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Profile'), centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                'Select Profile Picture',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8.0,
                  mainAxisSpacing: 8.0,
                ),
                itemCount: predefinedImages.length,
                itemBuilder: (context, index) {
                  final imagePath = predefinedImages[index];
                  return GestureDetector(
                    onTap: () => selectProfilePicture(imagePath),
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: updatedProfilePicture == imagePath
                              ? Colors.blue
                              : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          imagePath,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 16),
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
              Text(
                'Interests',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8),
              Wrap(
                spacing: 8.0,
                children: updatedInterests.map((interest) {
                  return Chip(
                    label: Text(interest),
                    onDeleted: () => removeInterest(interest),
                  );
                }).toList(),
              ),
              TextField(
                controller: interestController,
                decoration: InputDecoration(labelText: 'Add Interest'),
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  widget.onUpdate(
                    firstNameController.text,
                    lastNameController.text,
                    bioController.text,
                    updatedProfilePicture ?? widget.profile.profilePicture,
                    updatedInterests,
                  );
                   if (interestController.text.isNotEmpty) {
                    addInterest(interestController.text);
                    interestController.clear();
                  }
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Profile updated successfully!',
                        style: TextStyle(color: Colors.white),
                      ),
                      duration: Duration(seconds: 2),
                      backgroundColor: Colors.blueAccent,
                    ),
                  );
                  Navigator.pop(context);
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
