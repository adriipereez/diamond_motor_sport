import 'package:diamond_motor_sport/paginas/Login.dart';
import 'package:diamond_motor_sport/paginas/Registro.dart';
import 'package:flutter/material.dart';

class LoginORegistro extends StatefulWidget {

  const LoginORegistro({super.key});

  @override
  State<LoginORegistro> createState() => _LoginORegistroState();
}

class _LoginORegistroState extends State<LoginORegistro> {
  bool muestraPaginaLogin = true;

  void IntercambiarPaginasLoginRegistro() {
    setState(() {
      muestraPaginaLogin = !muestraPaginaLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (muestraPaginaLogin) {
      return Login(alHacerClick: IntercambiarPaginasLoginRegistro,);
    } else {
      return Registro(alHacerClick: IntercambiarPaginasLoginRegistro,);
    }
  }
}
