import 'dart:developer';

import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final String additionalTitle;
  final bool
      showBottomLine; // Nuevo parámetro para controlar la visibilidad de la línea

  const CustomAppBar({
    Key? key,
    this.titleText = "",
    this.additionalTitle = "DIAMOND MOTOR SPORT",
    this.showBottomLine =
        true, // Valor por defecto es true para mostrar la línea
  }) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;



    return PreferredSize(
      preferredSize: preferredSize,
      child: Stack(
        children: [
          AppBar(
            backgroundColor: Color.fromARGB(255, 0, 0, 0),
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: Image.asset('assets/pp.png', height: 45),
                  ),
                ),
                if (user != null)
                  GestureDetector(
                    onTap: () {
                      final RenderBox overlay = Overlay.of(context)!
                          .context
                          .findRenderObject() as RenderBox;

                      final Offset offset = Offset(
                        MediaQuery.of(context).size.width - 20,
                        MediaQuery.of(context).padding.top + kToolbarHeight + 8,
                      );

                      showMenu(
                        context: context,
                        position: RelativeRect.fromRect(
                          offset & Size(1, 1),
                          Offset.zero & overlay.size,
                        ),
                        items: <PopupMenuEntry>[
                          PopupMenuItem(
                            child: Container(
                              color: Colors.black, // Cambiado a negro
                              padding: EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  FutureBuilder(
                                    future: ServicioAuth().obtenerDatosUsuario(user.uid), 
                                    builder: (context, snapshot) {
                                      
                                      if (snapshot.hasError) {
                                        return Text("Error");
                                      }

                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                        return Text("Cargando datos");
                                      }
                                      return Text(
                                        '¡Hola ${snapshot.data!}!',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: 20,
                                          color: const Color.fromARGB(255, 255, 255, 255),
                                        ),);
                                    }
                                    
                                  ),
                                  SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pop(context); // Cierra el menú emergente
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 63, 32, 32),
                                    ), // Cambiado el color del botón
                                    child: Text(
                                      'Editar Perfil',
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255,
                                              255,
                                              253,
                                              253)), // Cambiado el color del texto
                                    ),
                                  ),
                                  SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      ServicioAuth().cerrarsesion();
                                      Navigator.pop(context); // Cierra el menú emergente
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          Color.fromARGB(255, 63, 32, 32),
                                    ),
                                    child: Text(
                                      'Cerrar Sesión',
                                      style: TextStyle(
                                          color: const Color.fromARGB(
                                              255,
                                              255,
                                              255,
                                              255)), // Cambiado el color del texto
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    child: Icon(Icons.person, color: Colors.white),
                  ),
              ],
            ),
          ),
          if (showBottomLine)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 2,
                color: Colors.white,
              ),
            ),
        ],
      ),
    );
  }
}
