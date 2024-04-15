import 'package:diamond_motor_sport/auth/login_o_registro.dart';
import 'package:diamond_motor_sport/paginas/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class PortalAuth extends StatelessWidget {
  const PortalAuth({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if(snapshot.hasData){
            return const Home();
          } else {
            return const LoginORegistro();
          }
        },
      ),
    );
  }
}