import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final String additionalTitle;

  const CustomAppBar({Key? key, this.titleText = "Diamond Motor Sport", this.additionalTitle = "DIAMOND MOTOR SPORT"}) : super(key: key);

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 141, 137, 137),
      title: Row(
        children: [
          Text(
            titleText,
            style: GoogleFonts.novaMono(
              color: const Color.fromARGB(255, 0, 0, 0),
              fontWeight: FontWeight.bold, 
              fontSize: 22, 
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(right: 7.0), // Ajusta la posición del logotipo hacia la izquierda
                  child: Image.asset(
                    'assets/diamante.png',
                    width: 60, 
                    height: 60, 
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 130.0), // Ajusta la posición del texto adicional hacia la derecha
                  child: Text(
                    additionalTitle,
                    style: GoogleFonts.novaMono(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontWeight: FontWeight.bold, 
                      fontSize: 30, 
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
