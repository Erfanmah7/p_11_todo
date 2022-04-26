import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:p_11_todo/models/todo.dart';
import 'package:p_11_todo/screens/home_screen.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(todoAdapter());
  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const Home(),
      theme: ThemeData.dark(),
    );
  }
}
