import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:diamond_motor_sport/componentes/drawerrouter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:diamond_motor_sport/paginas/home.dart'; // No necesitas importar dos veces home.dart

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String titleText;
  final String additionalTitle;
  final bool showBottomLine;

  const CustomAppBar({
    Key? key,
    this.titleText = "",
    this.additionalTitle = "DIAMOND MOTOR SPORT",
    this.showBottomLine = true,
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
            backgroundColor: const Color.fromARGB(255, 0, 0, 0),
            automaticallyImplyLeading: false,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.menu, color: Colors.white),
                  onPressed: () {
                    Scaffold.of(context).openDrawer();
                  },
                ),
                Stack(
                  children: [
                    Title(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      child: Text(
                        titleText,
                        style: TextStyle(
                            color: const Color.fromARGB(255, 255, 255, 255)),
                      ),
                    ),
                  ],
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.center,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, DrawerRoutes.principal1);
                      },
                      child: Image.asset('assets/pp.png', height: 45),
                    ),
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
                              color: Colors.black,
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: <Widget>[
                                  FutureBuilder(
                                    future: ServicioAuth()
                                        .obtenerDatosUsuario(user.uid),
                                    builder: (context, snapshot) {
                                      if (snapshot.hasError) {
                                        return const Text("Error");
                                      }

                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return const Text("Cargando datos");
                                      }
                                      return Text(
                                        '¡ Hola ${snapshot.data!} !',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
                                        ),
                                      );
                                    },
                                  ),
                                  const SizedBox(height: 16),
                                  ElevatedButton(
                                    onPressed: () {
                                      Navigator.pushReplacementNamed(
                                          context, DrawerRoutes.Editarperfil);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 63, 32, 32),
                                    ),
                                    child: const Text(
                                      'Editar Perfil',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 253, 253)),
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ElevatedButton(
                                    onPressed: () {
                                      ServicioAuth().cerrarsesion();
                                      Navigator.pop(context);
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromARGB(255, 63, 32, 32),
                                    ),
                                    child: const Text(
                                      'Cerrar Sesión',
                                      style: TextStyle(
                                          color: Color.fromARGB(
                                              255, 255, 255, 255)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                    child: const Icon(Icons.person, color: Colors.white),
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
