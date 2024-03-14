// ignore: unused_import
import 'package:diamond_motor_sport/gridanuncios.dart';
import 'package:diamond_motor_sport/paginas/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: GridAnuncios(),
    );
  }
}