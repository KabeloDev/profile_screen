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
  final Function(String, String, String, String, List<String>, Map<String, IconData>) onUpdate;

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
  IconData? selectedIcon; // Controller to store the selected icon
  String? updatedProfilePicture;
  List<String> updatedInterests = [];
  Map<String, IconData> interestIcons =
      {}; // Map to store interests and their icons
  final List<String> predefinedImages = [
    'assets/profile1.jpg',
    'assets/profile2.jpg',
    'assets/profile3.jpg',
    'assets/profile4.jpg',
    'assets/profile5.jpg',
    'assets/profile6.jpg',
  ];

  final List<IconData> predefinedIcons = [
  Icons.code,
  Icons.camera_alt,
  Icons.flight_takeoff,
  Icons.videogame_asset,
  Icons.music_note,
  Icons.star,
  Icons.sports_soccer,
  Icons.book,
  Icons.directions_bike,
  Icons.brush,
  Icons.android,
  Icons.spa,
  Icons.work,
  Icons.downhill_skiing,
  Icons.pool,
  Icons.local_cafe,
  Icons.hiking,
  Icons.laptop,
  Icons.watch,
  Icons.pets,
  Icons.build,
  Icons.chat,
  Icons.group,
  Icons.local_hospital,
  Icons.fitness_center,
  Icons.shopping_cart,
  Icons.headset,
  Icons.local_drink,
  Icons.location_on,
  Icons.movie,
  Icons.music_video,
  Icons.access_alarm,
  Icons.accessibility,
  Icons.airplanemode_active,
  Icons.all_inbox,
  Icons.arrow_forward,
  Icons.assistant,
  Icons.atm,
  Icons.bookmark,
  Icons.camera,
  Icons.car_rental,
  Icons.cloud,
  Icons.cloud_upload,
  Icons.dashboard,
  Icons.directions_car,
  Icons.electric_car,
  Icons.email,
  Icons.favorite,
  Icons.fingerprint,
  Icons.flash_on,
  Icons.folder,
  Icons.gamepad,
  Icons.golf_course,
  Icons.hd,
  Icons.home,
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

  void addInterest(String interest, IconData icon) {
    if (!updatedInterests.contains(interest)) {
      setState(() {
        updatedInterests.add(interest);
        interestIcons[interest] = icon; // Map the interest to the selected icon
      });
    }
  }

  void removeInterest(String interest) {
    setState(() {
      updatedInterests.remove(interest);
      interestIcons.remove(interest); // Remove the icon mapping as well
    });
  }

  void showIconSelectionDialog(String interest) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Select an Icon'),
          content: Wrap(
            spacing: 8.0,
            runSpacing: 8.0,
            children:
                predefinedIcons.map((icon) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIcon = icon; // Store the selected icon
                      });
                      Navigator.pop(context);
                      addInterest(
                        interest,
                        icon,
                      ); // Add the interest with the selected icon
                    },
                    child: Icon(icon, size: 32, color: Colors.blue),
                  );
                }).toList(),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Update Profile'), centerTitle: true),
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
                          color:
                              updatedProfilePicture == imagePath
                                  ? Colors.blue
                                  : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(imagePath, fit: BoxFit.cover),
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
                children:
                    updatedInterests.map((interest) {
                      return Chip(
                        avatar: Icon(
                          interestIcons[interest] ?? Icons.star,
                        ), // Display the icon
                        label: Text(interest),
                        onDeleted: () => removeInterest(interest),
                      );
                    }).toList(),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: interestController,
                      decoration: InputDecoration(labelText: 'Add Interest'),
                    ),
                  ),
                  SizedBox(width: 40), // spacing between TextField and button
                  ElevatedButton(
                    onPressed: () {
                      showIconSelectionDialog(interestController.text);
                    },
                    child: Text('Select Interest Icon'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (interestController.text.isNotEmpty) {
                    addInterest(
                      interestController.text,
                      selectedIcon ?? Icons.star,
                    );
                    interestController.clear();
                  }

                  widget.onUpdate(
                    firstNameController.text,
                    lastNameController.text,
                    bioController.text,
                    updatedProfilePicture ?? widget.profile.profilePicture,
                    updatedInterests,
                    interestIcons,
                  );
                  
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
