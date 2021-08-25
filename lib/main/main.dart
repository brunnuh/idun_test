import 'package:flutter/material.dart';

import 'setup_locator.dart';

import '../ui/pages/listIdun/list_idun_page.dart';


void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListIdunPage(),
    );
  }
}


