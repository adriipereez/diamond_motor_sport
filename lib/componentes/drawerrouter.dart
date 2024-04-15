import 'package:diamond_motor_sport/auth/portal_auth.dart';
import 'package:diamond_motor_sport/paginas/Chat.dart';
import 'package:diamond_motor_sport/paginas/SobreNosotrosYContacto.dart';
import 'package:diamond_motor_sport/paginas/gridanuncios.dart';
import 'package:diamond_motor_sport/paginas/home.dart';
import 'package:flutter/material.dart';
import 'package:diamond_motor_sport/auth/login_o_registro.dart';

class DrawerRoutes {
  static const String portalAuth = '/';
  static const String loginORegistro = '/loginRegistro';
  static const String principal1 = '/home';
  static const String chat = '/Chat';
  static const String gridAnuncios1= '/GridAnuncios';
  static const String sobreNosotros1= '/SobreNosotros';

  static Route<dynamic> generateDrawerRoute(RouteSettings settings) {
    switch (settings.name) {
      case portalAuth:
        return MaterialPageRoute(builder: (_) => const PortalAuth());
      case loginORegistro:
        return MaterialPageRoute(builder: (_) => const LoginORegistro());
      case principal1:
        return MaterialPageRoute(builder: (_) => const Home());
      case chat:
        return MaterialPageRoute(builder: (_) => const Chat());
      case gridAnuncios1:
        return MaterialPageRoute(builder: (_) => const GridAnuncios());
      case sobreNosotros1:
        return MaterialPageRoute(builder: (_) => const SobreNosotros());
      default:
        return MaterialPageRoute(
            builder: (_) =>const Scaffold(body: Center(child: Text('Ruta no encontrada'))));
    }
  }
}
