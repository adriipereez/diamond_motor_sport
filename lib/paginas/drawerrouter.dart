import 'package:diamond_motor_sport/auth/portal_auth.dart';
import 'package:diamond_motor_sport/paginas/home.dart';
import 'package:flutter/material.dart';
import 'package:diamond_motor_sport/auth/login_o_registro.dart';

class DrawerRoutes {
  static const String portalAuth = '/';
  static const String loginORegistro = '/loginRegistro';
  static const String principal1 = '/home';
  static const String principal2 = '/principa copy';

  static Route<dynamic> generateDrawerRoute(RouteSettings settings) {
    switch (settings.name) {
      case portalAuth:
        return MaterialPageRoute(builder: (_) => PortalAuth());
      case loginORegistro:
        return MaterialPageRoute(builder: (_) => LoginORegistro());
      case principal1:
        return MaterialPageRoute(builder: (_) => Home());
      case principal2:
        //return MaterialPageRoute(builder: (_) => );
      default:
        return MaterialPageRoute(
            builder: (_) =>Scaffold(body: Center(child: Text('Ruta no encontrada'))));
    }
  }
}
