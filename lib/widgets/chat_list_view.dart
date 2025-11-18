import 'package:flutter/material.dart';

class ChatListView extends StatelessWidget {
  const ChatListView({super.key});

  @override
  Widget build(BuildContext context) {
    final users = [
      {'name': 'Cameron Williamson', 'issue': "Can't log in", 'time': '9:32 AM'},
      {'name': 'Kristin Watson', 'issue': "Error message", 'time': '9:34 AM'},
      {'name': 'Kathryn Murphy', 'issue': "Payments", 'time': '9:34 AM'},
      {'name': 'Ralph Edwards', 'issue': "Account assis", 'time': '9:35 AM'},
    ];

    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return ListTile(
          leading: const CircleAvatar(child: Icon(Icons.person)),
          title: Text(user['name']!),
          subtitle: Text(user['issue']!),
          trailing: Text(user['time']!),
          selected: index == 0, 
          onTap: () {
            // Navigation logic here
          },
        );
      },
    );
  }
}