import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class BombollaMensaje extends StatelessWidget {
  final Color colorBombolla;
  final String mensaje;
  final Timestamp timestamp;

  const BombollaMensaje({
    Key? key,
    required this.colorBombolla,
    required this.mensaje,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //String formattedTime ="${timestamp.toDate().hour.toString().padLeft(2, '0')}:${timestamp.toDate().minute.toString().padLeft(2, '0')}";
    DateTime now = DateTime.now();
    DateTime messageTime = timestamp.toDate();

    Duration difference = now.difference(messageTime);

    String formattedTime;
    if (difference.inDays >= 1 && difference.inDays <= 7) {
      formattedTime =
          'hace ${difference.inDays} día${difference.inDays > 1 ? 's' : ''}';
    } else {
      formattedTime =
          '${messageTime.hour.toString().padLeft(2, '0')}:${messageTime.minute.toString().padLeft(2, '0')}';
    }
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: colorBombolla,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(10),
          child: Text(mensaje),
        ),
        Container(
          child: Text(formattedTime), // Muestra el tiempo del mensaje
        )
      ],
    );
  }
}
