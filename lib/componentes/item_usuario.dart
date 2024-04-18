import 'package:flutter/material.dart';

class Itemusuario extends StatelessWidget {
  final String emailUsuario;

  final void Function()? Ontap;

  const Itemusuario({
    super.key,
    required this.emailUsuario,
    required this.Ontap,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: Ontap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.amber,
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 25,
        ),
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            const Icon(Icons.person),
            const SizedBox(width: 10,),
            Text(emailUsuario),
          ],
        ),
      ),
    );
  }
}