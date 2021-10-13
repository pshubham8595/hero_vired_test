import 'package:flutter/material.dart';
import 'package:hero_vired_test/test.dart';

import 'RootPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.red,
      ),
      home: RootPage(),
    );
  }
}
