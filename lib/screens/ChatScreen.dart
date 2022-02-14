import 'package:flutter/material.dart';
import 'package:grape_doc/screens/BlogScreen.dart';
import 'package:grape_doc/screens/CameraScreen.dart';
import 'HomeScreen.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {



  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Chat'));
  }
}
