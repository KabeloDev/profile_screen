import 'package:flutter/material.dart';
import 'package:profile_screen/Mode/mode.dart';
import 'package:provider/provider.dart';

class SkillsChips extends StatelessWidget {
  final Map<String, String> skills = const {
  'Flutter': 'I use Flutter to build modern, responsive UIs for mobile platforms with a strong focus on smooth animations and cross-platform compatibility.',
  '.NET Core': 'I work with .NET Core to develop robust, scalable backend APIs that support dynamic data-driven applications.',
  'SQL Server': 'I manage relational data using SQL Server, designing efficient schemas and writing queries to ensure data integrity and performance.',
  'Firebase': 'I use Firebase for backend services like real-time databases, user authentication, and cloud storage to streamline app development.',
};


  const SkillsChips({super.key});

  @override
  Widget build(BuildContext context) {
    final modeController = Provider.of<ModeController>(context);

    return Wrap(
      spacing: 8,
      children: skills.entries.map((entry) {
        return ActionChip(
          label: Text(
            entry.key,
            style: TextStyle(
              color:  modeController.isDarkMode ? Colors.white : Colors.black,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor:  modeController.isDarkMode ? Colors.grey[900] : Colors.grey[300],
          elevation: 4,
          shadowColor: modeController.isDarkMode ? Colors.white.withAlpha(100) : Colors.black.withAlpha(200),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          onPressed: () {
            showModalBottomSheet(
              context: context,
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              builder: (context) => Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      entry.key,
                      style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      entry.value,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
