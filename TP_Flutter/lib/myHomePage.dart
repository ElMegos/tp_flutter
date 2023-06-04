import 'package:flutter/material.dart';
import 'package:tp_flutter/myListPage.dart';
import 'package:tp_flutter/post.dart';

class MyHomePage extends StatelessWidget {
  final String title;

  const MyHomePage({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: MyListPage(),
    );
  }
}
