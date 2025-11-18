import 'package:flutter/material.dart';
import 'widgets/chat_list_view.dart';
import 'widgets/chat_detail_view.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Helpdesk Chat App (Flutter)',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const HelpdeskChatScreen(),
    );
  }
}

const double kTabletBreakpoint = 600.0;

class HelpdeskChatScreen extends StatelessWidget {
  const HelpdeskChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Helpdesk Chat'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth >= kTabletBreakpoint) {
            return const Row(
              children: [
                SizedBox(
                  width: 300, 
                  child: ChatListView(),
                ),
                VerticalDivider(width: 1),
                Expanded(
                  child: ChatDetailView(userName: 'Cameron Williamson'),
                ),
              ],
            );
          } else {
            return const ChatDetailView(userName: 'Cameron Williamson');
          }
        },
      ),
    );
  }
}