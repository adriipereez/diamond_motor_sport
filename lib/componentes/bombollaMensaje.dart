import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BombollaMensaje extends StatelessWidget {

  final Color colorBombolla;
  final String mensaje;

  const BombollaMensaje({
    super.key,
    required this.colorBombolla,
    required this.mensaje,
    });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: colorBombolla,
        borderRadius: BorderRadius.circular(15),
      ),
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.all(10),
      child: Text(mensaje),
    );
  }
}