import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  @override
  State<ListPage> createState() => _LikePageState();
}

class _LikePageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text('Like Page'),
      ),
      body: Container(
        color: Colors.blue,
        child: Text('Like Page'),
      ),
    );
  }
}