import 'package:diamond_motor_sport/auth/login_o_registro.dart';
import 'package:diamond_motor_sport/auth/portal_auth.dart';
import 'package:diamond_motor_sport/firebase_options.dart';
import 'package:diamond_motor_sport/paginas/Login.dart';
import 'package:diamond_motor_sport/paginas/Registro.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp( options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp() );

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PortalAuth(),
    );
  }
}
