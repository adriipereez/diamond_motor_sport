import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  final serviceAuth = ServicioAuth();
  Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: ElevatedButton(
        child: Text("hola"),
        onPressed: () => serviceAuth.cerrarsesion()
      ),
    );

  }
}