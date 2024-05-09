import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:diamond_motor_sport/componentes/drawerrouter.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class CustomDrawer extends StatefulWidget {
  CustomDrawer({Key? key}) : super(key: key);

  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final servicio = ServicioAuth();
  bool _isAdmin = false;

  @override
  void initState() {
    super.initState();
    _checkAdminStatus();
  }

  Future<void> _checkAdminStatus() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      _isAdmin = await servicio.esUsuarioAdmin(user.uid);
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final user = _auth.currentUser;

    return Drawer(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacementNamed(
                      context, DrawerRoutes.principal1);
                },
                child: DrawerHeader(
                  child: Image.asset(
                    'assets/pp.png',
                    width: 250,
                    height: 250,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.home,
                          color: Color.fromARGB(255, 255, 0, 0)),
                      title: const Text("Página principal",
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, DrawerRoutes.principal1);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.post_add,
                          color: Color.fromARGB(255, 255, 0, 0)),
                      title: const Text("Vehiculos",
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, DrawerRoutes.gridAnuncios1);
                      },
                    ),
                    ListTile(
                      leading: const Icon(Icons.info_outline,
                          color: Color.fromARGB(255, 255, 0, 0)),
                      title: const Text("Sobre nosotros",
                          style: TextStyle(color: Colors.white)),
                      onTap: () {
                        Navigator.pushReplacementNamed(
                            context, DrawerRoutes.gridAnuncios1);
                      },
                    ),
                    user == null
                        ? const SizedBox.shrink()
                        : ListTile(
                            leading: const Icon(Icons.chat,
                                color: Color.fromARGB(255, 255, 0, 0)),
                            title: const Text("Chats",
                                style: TextStyle(color: Colors.white)),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, DrawerRoutes.Listachats2);
                            },
                          ),
                    const SizedBox(height: 50),
                    const Divider(),
                    const SizedBox(height: 50),
                    user != null
                        ? const SizedBox.shrink()
                        : ListTile(
                            leading: const Icon(Icons.login,
                                color: Color.fromARGB(255, 255, 0, 0)),
                            title: const Text("Login o Registro",
                                style: TextStyle(color: Colors.white)),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, DrawerRoutes.loginORegistro);
                            },
                          ),
                    if (_isAdmin)
                      ListTile(
                        leading: const Icon(Icons.admin_panel_settings,
                            color: Color.fromARGB(255, 0, 255, 42)),
                        title: const Text("Panel de administración",
                            style: TextStyle(
                                color: Color.fromARGB(255, 0, 255, 42))),
                        onTap: () {
                          // Navegar a la pantalla de administración
                          Navigator.pushReplacementNamed(
                              context, DrawerRoutes.mensajesform);
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
