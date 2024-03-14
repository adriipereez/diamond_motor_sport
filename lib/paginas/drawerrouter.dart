import 'package:diamond_motor_sport/auth/portal_auth.dart';
import 'package:diamond_motor_sport/paginas/principal%20copy.dart';
import 'package:flutter/material.dart';
import 'package:diamond_motor_sport/auth/login_o_registro.dart';
import 'package:diamond_motor_sport/paginas/principal.dart';

class DrawerRoutes {
  static const String portalAuth = '/';
  static const String loginORegistro = '/loginRegistro';
  static const String principal1 = '/principal';
  static const String principal2 = '/principa copy';

  static Route<dynamic> generateDrawerRoute(RouteSettings settings) {
    switch (settings.name) {
      case portalAuth:
        return MaterialPageRoute(builder: (_) => PortalAuth());
      case loginORegistro:
        return MaterialPageRoute(builder: (_) => LoginORegistro());
      case principal1:
        return MaterialPageRoute(builder: (_) => Inicio());
      case principal2:
        return MaterialPageRoute(builder: (_) => Inicio2());
      default:
        return MaterialPageRoute(
            builder: (_) =>Scaffold(body: Center(child: Text('Ruta no encontrada'))));
    }
  }
}
