import 'package:flutter/material.dart';

class Footer extends StatefulWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _FooterState createState() => _FooterState();
}

class _FooterState extends State<Footer> {
  bool isHoveringAvisoLegal = false;
  bool isHoveringPoliticas = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            '© 2024 Diamond Motor Sport',
            style: TextStyle(color: Colors.white),
          ),
          const SizedBox(width: 20.0),
          MouseRegion(
            onEnter: (event) {
              setState(() {
                isHoveringAvisoLegal = true;
              });
            },
            onExit: (event) {
              setState(() {
                isHoveringAvisoLegal = false;
              });
            },
            child: Text(
              'Aviso Legal',
              style: TextStyle(
                color: isHoveringAvisoLegal
                    ? const Color.fromARGB(255, 88, 59, 255)
                    : Colors.white,
                decoration: isHoveringAvisoLegal
                    ? TextDecoration.underline
                    : TextDecoration.none,
              ),
            ),
          ),
          const SizedBox(width: 20.0),
          MouseRegion(
            onEnter: (event) {
              setState(() {
                isHoveringPoliticas = true;
              });
            },
            onExit: (event) {
              setState(() {
                isHoveringPoliticas = false;
              });
            },
            child: GestureDetector(
              onTap: () {},
              child: Text(
                'Políticas de Privacidad',
                style: TextStyle(
                  color: isHoveringPoliticas
                      ? const Color.fromARGB(255, 88, 59, 255)
                      : Colors.white,
                  decoration: isHoveringPoliticas
                      ? TextDecoration.underline
                      : TextDecoration.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 30.0),
          Image.asset(
            'assets/i.png', // Ruta de la imagen de Instagram
            width: 25.0,
            height: 25.0,
          ),
          const SizedBox(width: 10.0),
          const Icon(
            Icons.facebook,
            color: Colors.white,
            size: 30.0,
          ),
          const SizedBox(width: 10.0),
          Image.asset(
            'assets/yt.png', // Ruta de la imagen de Instagram
            width: 25.0,
            height: 30.0,
          ),
        ],
      ),
    );
  }
}