import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:flutter/material.dart';

class Inicio2 extends StatelessWidget {
  final serviceAuth = ServicioAuth();
  Inicio2({super.key});

  @override
  Widget build(BuildContext context) {
    return  Container(
      child: ElevatedButton(
        child: Text("adios"),
        onPressed: () => serviceAuth.cerrarsesion()
      ),
    );

  }
}