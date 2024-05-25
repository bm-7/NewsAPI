import 'package:api/PAPI.dart';
import 'package:api/api.dart';
import 'package:api/myapi/maapi.dart';
import 'package:api/myapi/postapi.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: NewsApi(),
    );
  }
}
