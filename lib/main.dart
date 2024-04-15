
import 'package:diamond_motor_sport/auth/portal_auth.dart';
import 'package:diamond_motor_sport/firebase_options.dart';
import 'package:diamond_motor_sport/componentes/drawerrouter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PortalAuth(),
      onGenerateRoute: DrawerRoutes.generateDrawerRoute,
    );
  }
}
