import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'Objects/person_entry.dart';
import 'data/database.dart';
import 'pages/home.dart';

void main() async {
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  var box = await Hive.openBox<PersonEntry>('mybox');
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: MyAppExtension(),
      home: HomePage(),
      theme: ThemeData(primarySwatch: Colors.lightBlue, useMaterial3: true),
    );
  }
}
