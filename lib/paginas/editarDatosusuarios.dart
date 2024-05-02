import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:diamond_motor_sport/componentes/drawerrouter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class EditarDatosUsuario extends StatefulWidget {
  const EditarDatosUsuario({super.key});

  @override
  State<EditarDatosUsuario> createState() => _EditarDatosUsuarioState();
}

class _EditarDatosUsuarioState extends State<EditarDatosUsuario> {
  final servicioAuth = ServicioAuth();
  final TextEditingController _nombreUsu = TextEditingController();
  final TextEditingController _telefonoUsu = TextEditingController();
  final TextEditingController _apellidoUsu = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cargarDatosUsuario(); // Cargar los datos del usuario al inicializar la pantalla
  }

  Future<void> _cargarDatosUsuario() async {
    try {
      // Obtener el ID del usuario actual
      String uid = ServicioAuth().getUsuarioActual()!.uid;

      // Obtener los datos del usuario de Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore
          .instance
          .collection("Usuarios")
          .doc(uid)
          .get();

      if (snapshot.exists) {
        Map<String, dynamic>? userData = snapshot.data();
        if (userData != null) {
          setState(() {
            _nombreUsu.text = userData['nombre'] ?? '';
            _telefonoUsu.text = userData['telefono'] ?? '';
            _apellidoUsu.text = userData['apellido'] ?? '';
          });
        }
      }
    } catch (e) {
      print("Error al cargar los datos del usuario: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(),
      body: SafeArea(
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/c63.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: Container(
                width: 600,
                padding: const EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(180, 0, 0, 0),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Color.fromARGB(122, 255, 255, 255),
                    width: 10,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16.0),
                      child: Text(
                        'Editar perfil',
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    TextField(
                      controller: _nombreUsu,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 255, 8),
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Nombre',
                        labelStyle: TextStyle(color: Colors.white),
                        fillColor: Color.fromARGB(200, 22, 21, 21),
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _apellidoUsu,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 255, 8),
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Apellido',
                        labelStyle: TextStyle(color: Colors.white),
                        fillColor: Color.fromARGB(200, 22, 21, 21),
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    TextField(
                      controller: _telefonoUsu,
                      style: const TextStyle(
                        color: Color.fromARGB(255, 0, 255, 8),
                      ),
                      decoration: const InputDecoration(
                        labelText: 'Teléfono',
                        labelStyle: TextStyle(color: Colors.white),
                        fillColor: Color.fromARGB(200, 22, 21, 21),
                        filled: true,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 40.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () async {
                            String nuevoNombre = _nombreUsu.text;
                            String nuevoTelefono = _telefonoUsu.text;
                            String nuevoApellido = _apellidoUsu.text;

                            try {
                              String uid =
                                  ServicioAuth().getUsuarioActual()!.uid;

                              await FirebaseFirestore.instance
                                  .collection("Usuarios")
                                  .doc(uid)
                                  .update({
                                "nombre": nuevoNombre,
                                "telefono": nuevoTelefono,
                                "apellido": nuevoApellido,
                              });

                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Datos actualizados"),
                                    content: const Text(
                                        "Se han guardado los cambios correctamente."),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Aceptar"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            } catch (error) {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text("Error"),
                                    content: Text(
                                        "Ocurrió un error al guardar los datos: $error"),
                                    actions: [
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text("Aceptar"),
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Color.fromARGB(255, 30, 255, 1),
                            onPrimary: Colors.white,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(15, 10),
                          ),
                          child: const Text(
                            'Guardar datos',
                            style: TextStyle(
                              color: Colors.black,
                              height: 3,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                        const SizedBox(
                          width: 50,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            try {
                              await ServicioAuth().deleteAccount();
                              Navigator.pushReplacementNamed(
                                  context, DrawerRoutes.principal1);
                              // Mostrar SnackBar de "Cuenta eliminada correctamente"
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Cuenta eliminada correctamente'),
                                  backgroundColor:
                                      const Color.fromARGB(255, 76, 175, 80),
                                  duration: const Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                              );
                            } catch (e) {
                              // Mostrar SnackBar de error
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text('Error al eliminar la cuenta: $e'),
                                  backgroundColor:
                                      const Color.fromARGB(255, 255, 22, 5),
                                  duration: const Duration(seconds: 3),
                                  behavior: SnackBarBehavior.floating,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16.0),
                                  ),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: const Color.fromARGB(255, 250, 28, 28),
                            onPrimary: Colors.white,
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            minimumSize: const Size(15, 10),
                          ),
                          child: const Text(
                            'Eliminar cuenta',
                            style: TextStyle(
                              color: Colors.black,
                              height: 3,
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
