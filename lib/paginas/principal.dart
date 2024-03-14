import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:flutter/material.dart';

class Inicio extends StatelessWidget {
  final serviceAuth = ServicioAuth();
  Inicio({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: "LOGIN",
      ), // Usa CustomAppBar como el appBar
      drawer: const CustomDrawer(),
      body: Container(
        child: ElevatedButton(
            child: Text("hola"), onPressed: () => serviceAuth.cerrarsesion()),
      ),
    );
  }
}