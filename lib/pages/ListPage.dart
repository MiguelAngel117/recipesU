import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _LikePageState();
}

class _LikePageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Like Page'),
      ),
      body: Container(
        color: Colors.blue,
        child: const Text('Like Page'),
      ),
    );
  }
}
