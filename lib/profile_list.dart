// lib/screens/profile_list.dart
import 'package:flutter/material.dart';
import '../model/profile.dart'; // Import the model class

class ProfileList extends StatelessWidget {
  final List<Profile> profiles = [
    Profile(
      name: 'John Doe',
      age: 28,
      profileURL: 'https://example.com/profile1.jpg',
    ),
    Profile(
      name: 'Jane Smith',
      age: 25,
      profileURL: 'https://example.com/profile2.jpg',
    ),
    Profile(
      name: 'Jane Smith',
      age: 25,
      profileURL: 'https://example.com/profile2.jpg',
    ),
    Profile(
      name: 'Jane Smith',
      age: 25,
      profileURL: 'https://example.com/profile2.jpg',
    ),
    Profile(
      name: 'Jane Smith',
      age: 25,
      profileURL: 'https://example.com/profile2.jpg',
    ),
    Profile(
      name: 'Jane Smith',
      age: 25,
      profileURL: 'https://example.com/profile2.jpg',
    )
    // Add more profiles here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: profiles.length,
        itemBuilder: (context, index) {
          final profile = profiles[index];
          return Card(
            color: const Color(0xFFAD687B ),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(profile.profileURL),
              ),
              title: Text(profile.name),
              subtitle: Text('Age: ${profile.age}'),
            ),
          );
        },
        physics: AlwaysScrollableScrollPhysics(),
      ),
    );
  }
}
