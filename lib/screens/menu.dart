// lib/screens/menu.dart
import 'package:flutter/material.dart';
import 'package:coffee_app/screens/schedule.dart';
import 'package:coffee_app/screens/timetable.dart';

class MenuPage extends StatelessWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Menu"),
        backgroundColor: Colors.brown[400],
      ),
      body: ListView(
        children: [
          ListTile(
            leading: const Icon(Icons.schedule),
            title: const Text("Shift Schedule"),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WeeklyTimetableScreen()),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.person),
            title: const Text("Profile"),
            onTap: () {
              // TODO: Navigate to Profile Page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navigate to Profile')),
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.bar_chart),
            title: const Text("Daily Report"),
            onTap: () {
              // TODO: Navigate to Daily Report Page
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Navigate to Daily Report')),
              );
            },
          ),
        ],
      ),
    );
  }
}
