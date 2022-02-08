import 'package:flutter/material.dart';
import 'package:grape_doc/BlogScreen.dart';
import 'package:grape_doc/CameraScreen.dart';
import 'package:grape_doc/HomeScreen.dart';

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
