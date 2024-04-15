import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:diamond_motor_sport/componentes/drawerrouter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({Key? key}) : super(key: key);
  final servicio = ServicioAuth();

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    User? user = _auth.currentUser;

    return Drawer(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              DrawerHeader(
                child: Image.asset(
                  'assets/pp.png', // Ruta de la imagen personalizada
                  width:
                      250, // Ajusta el ancho de la imagen según tus necesidades
                  height:
                      250, // Ajusta la altura de la imagen según tus necesidades
                ),
              ),
              const SizedBox(
                  height: 20), // Espacio entre la imagen y los ListTile
              Container(
                alignment:
                    Alignment.center, // Centra horizontalmente los elementos
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home,
                          color: Colors.white), // Cambia el color del ícono
                      title: const Text("Página principal",
                          style: TextStyle(
                              color:
                                  Colors.white)), // Cambia el color del texto
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, DrawerRoutes.principal1);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.post_add, color: Colors.white),
                      title: const Text("Vehiculos",
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, DrawerRoutes.gridAnuncios1);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.info_outline,
                          color: Colors.white), // Cambia el color del ícono
                      title: const Text("Sobre nosotros",
                          style: TextStyle(
                              color:
                                  Colors.white)), // Cambia el color del texto
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, DrawerRoutes.gridAnuncios1);
                      },
                    ),
                    user == null
                        ? SizedBox.shrink()
                        : ListTile(
                            leading: const Icon(Icons.chat,
                                color:
                                    Colors.white), // Cambia el color del ícono
                            title: const Text("Chats",
                                style: TextStyle(
                                    color: Colors
                                        .white)), // Cambia el color del texto
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, DrawerRoutes.chats);
                            },
                          ),

                    const SizedBox(
                      height: 50,
                    ),
                    const Divider(), // Línea horizontal
                    const SizedBox(
                      height: 50,
                    ),
                    user != null
                        ? SizedBox.shrink()
                        : ListTile(
                            // Condición para mostrar o no el último ListTile
                            leading: const Icon(Icons.login,
                                color:
                                    Colors.white), // Cambia el color del ícono
                            title: const Text("Login o Registro",
                                style: TextStyle(
                                    color: Colors
                                        .white)), // Cambia el color del texto
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, DrawerRoutes.loginORegistro);
                            },
                          ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
