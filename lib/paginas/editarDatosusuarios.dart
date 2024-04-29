import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
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
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(),
      body: SafeArea(
          child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TextField(
                controller: _nombreUsu,
                decoration: InputDecoration(
                  labelText: 'Nombre',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _telefonoUsu,
                decoration: InputDecoration(
                  labelText: 'Teléfono',
                ),
              ),
              SizedBox(height: 16.0),
              TextField(
                controller: _apellidoUsu,
                decoration: InputDecoration(
                  labelText: 'Apellido',
                ),
              ),
              SizedBox(height: 50.0),
              ElevatedButton(
                  onPressed: () async {
                    // Obtener los datos actualizados de los campos de texto
                    String nuevoNombre = _nombreUsu.text;
                    String nuevoTelefono = _telefonoUsu.text;
                    String nuevoApellido = _apellidoUsu.text;

                    try {
                      // Obtener el ID del usuario actual
                      String uid = ServicioAuth().getUsuarioActual()!.uid;

                      // Actualizar los datos en la colección de usuarios
                      await FirebaseFirestore.instance
                          .collection("Usuarios")
                          .doc(uid)
                          .update({
                        "nombre": nuevoNombre,
                        "telefono": nuevoTelefono,
                        "apellido": nuevoApellido,
                      });

                      // Mostrar un diálogo indicando que se guardaron los datos correctamente
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Datos actualizados"),
                            content: Text(
                                "Se han guardado los cambios correctamente."),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Aceptar"),
                              ),
                            ],
                          );
                        },
                      );
                    } catch (error) {
                      // Mostrar un diálogo indicando que ocurrió un error al guardar los datos
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text("Error"),
                            content: Text(
                                "Ocurrió un error al guardar los datos: $error"),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text("Aceptar"),
                              ),
                            ],
                          );
                        },
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.blue,
                    onPrimary: Colors.white,
                    elevation: 1,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    minimumSize: Size(15,
                        10), // Ajusta el tamaño mínimo del botón (ancho x alto)
                  ),
                  child: const Text(
                    'Guardar datos',
                    style: TextStyle(
                      color: Colors.black,
                      height: 5,
                    ),
                  )),
            ],
          ),
        ),
      )),
    );
  }
}
