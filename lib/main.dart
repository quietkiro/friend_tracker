import 'package:flutter/material.dart';
import 'package:friend_tracker/models/person.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'screens/home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(PersonAdapter());
  await Hive.openBox<Person>('people');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const Home(),
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.blueGrey[800],
          centerTitle: true,
        ),
        primarySwatch: Colors.blueGrey,
      ),
    );
  }
}
