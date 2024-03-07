import 'package:diamond_motor_sport/auth/login_o_registro.dart';
import 'package:diamond_motor_sport/paginas/principal.dart';
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
            return Inicio();
          } else {
            return const LoginORegistro();
          }
        },
      ),
    );
  }
}