import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../pages/result_list.dart';
import 'pages/home_screen.dart';
import 'pages/process_screen.dart';
import '../models/const.dart';

late Box box;

Future<void> main() async {
  await Hive.initFlutter();
  box = await Hive.openBox('box');
  //Hive.registerAdapter(MyObjectAdapter());
  uri = box.get('uriApi', defaultValue: '');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  String urlApi = '';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Home screen',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const HomeScreen(),
        '/process_screen': (context) => ProcessScreen(),
        '/result_list': (context) => ResultList(),
      },
    );
  }
}
