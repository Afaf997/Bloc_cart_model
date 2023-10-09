import 'package:cart_project/view/Home/ui/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'bloc Demo',
      theme: ThemeData(primaryColor: Colors.teal),
      home: HomePage(),
    );
  }
}
