import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:diamond_motor_sport/paginas/Login.dart';
import 'package:flutter/material.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart'; // Importa el widget CustomAppBar
import 'package:google_fonts/google_fonts.dart';

class Registro extends StatelessWidget {
  final void Function() alHacerClick;
  Registro({Key? key,required this.alHacerClick});
  final _formKey = GlobalKey<FormState>(); // GlobalKey para el formulario

  
  final TextEditingController controllerEmail = TextEditingController();
  final TextEditingController controllerPass = TextEditingController();
  final TextEditingController controllerPass2 = TextEditingController();
  final TextEditingController controlernombre = TextEditingController();
  final TextEditingController controlerapellido = TextEditingController();
  final TextEditingController controlertelefono = TextEditingController();

  void HacerRegistro(BuildContext context) async {
    final servicioAuth = ServicioAuth();
    try {
      servicioAuth.registroConEmailPassword(controllerEmail.text, controllerPass.text, controlernombre.text, controlerapellido.text, controlertelefono.text);
    } catch (e){
      showDialog(context: context, builder: (context) => AlertDialog(
        title: const Text("ERROR"),
        content: Text(e.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: "REGISTRO",
      ), // Usa CustomAppBar como el appBar
      drawer: const CustomDrawer(),
      body: Stack(
        // Utiliza un Stack para superponer widgets
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image:
                    AssetImage("assets/12.png"), // Ruta de la imagen de fondo
                fit: BoxFit
                    .cover, // Ajusta la imagen para que cubra toda el área
              ),
            ),
          ),      
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Container(
                  height: 1000,
                  width: 600,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 3),
                    color: const Color.fromARGB(
                        180, 0, 0, 0), // Cambia el color de fondo a negro
                    borderRadius:
                        BorderRadius.circular(20), // Agrega bordes redondos
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(60.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Text(
                            'REGISTRO',
                            style: GoogleFonts.novaMono(
                              color: Colors.white,
                              fontSize: 70,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 20.0),
                          TextFormField(
                            controller: controllerEmail,
                            cursorColor: Color.fromARGB(255, 255, 17, 0),
                            style: const TextStyle(
                                color: Colors
                                    .white), // Cambia el color de texto a blanco
                            decoration: const InputDecoration(
                              errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255,
                                  255), // Personaliza el color del mensaje de error
                              fontStyle: FontStyle
                                  .italic, // Personaliza el estilo del mensaje de error
                              fontWeight: FontWeight.bold),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 17,
                                        0)), // Cambia el color del borde cuando está enfocado
                              ),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              filled: true,
                              fillColor: Color.fromARGB(200, 22, 21, 21),
                              labelText: 'Correo',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                letterSpacing: 2,
                              ), // Cambia el color del texto del label a blanco
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Este campo es obligatorio *';
                              }
                              return null;
                            },
                            obscureText: false,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: controllerPass,
                            cursorColor: Color.fromARGB(255, 255, 17, 0),
                            style: const TextStyle(
                              color: Colors.white,
                            ), // Cambia el color de texto a blanco
                            decoration: const InputDecoration(
                              errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255,
                                  255), // Personaliza el color del mensaje de error
                              fontStyle: FontStyle
                                  .italic, // Personaliza el estilo del mensaje de error
                              fontWeight: FontWeight.bold),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 17,
                                        0)), // Cambia el color del borde cuando está enfocado
                              ),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              filled: true,
                              fillColor: Color.fromARGB(200, 22, 21, 21),
                              labelText: 'Contraseña',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                letterSpacing: 2,
                              ), // Cambia el color del texto del label a blanco
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Este campo es obligatorio *';
                              }
                              if(controllerPass.text != controllerPass2.text){
                                return '* Las contraseñas tienen que ser iguales *';
                              }
                              return null; 
                            },
                            obscureText: true,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: controllerPass2,
                            cursorColor: Color.fromARGB(255, 255, 17, 0),
                            style: const TextStyle(
                              color: Colors.white,
                            ), // Cambia el color de texto a blanco
                            decoration: const InputDecoration(
                              errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255,
                                  255), // Personaliza el color del mensaje de error
                              fontStyle: FontStyle
                                  .italic, // Personaliza el estilo del mensaje de error
                              fontWeight: FontWeight.bold),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 17,
                                        0)), // Cambia el color del borde cuando está enfocado
                              ),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              filled: true,
                              fillColor: Color.fromARGB(200, 22, 21, 21),
                              labelText: 'Confirma Contraseña',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                letterSpacing: 2,
                              ), // Cambia el color del texto del label a blanco
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Este campo es obligatorio *';
                              }
                              if(controllerPass.text != controllerPass2.text){
                                return '* Las contraseñas tienen que ser iguales *';
                              }
                              return null;
                            },
                            obscureText: true,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: controlernombre,
                            cursorColor: Color.fromARGB(255, 255, 17, 0),
                            style: const TextStyle(
                              color: Colors.white,
                            ), // Cambia el color de texto a blanco
                            decoration: const InputDecoration(
                              errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255,
                                  255), // Personaliza el color del mensaje de error
                              fontStyle: FontStyle
                                  .italic, // Personaliza el estilo del mensaje de error
                              fontWeight: FontWeight.bold),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 17,
                                        0)), // Cambia el color del borde cuando está enfocado
                              ),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              filled: true,
                              fillColor: Color.fromARGB(200, 22, 21, 21),
                              labelText: 'Nombre',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                letterSpacing: 2,
                              ), // Cambia el color del texto del label a blanco
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Este campo es obligatorio *';
                              }
                              return null;
                            },
                            obscureText: false,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: controlerapellido,
                            cursorColor: Color.fromARGB(255, 255, 17, 0),
                            style: const TextStyle(
                              color: Colors.white,
                            ), // Cambia el color de texto a blanco
                            decoration: const InputDecoration(
                              errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255,
                                  255), // Personaliza el color del mensaje de error
                              fontStyle: FontStyle
                                  .italic, // Personaliza el estilo del mensaje de error
                              fontWeight: FontWeight.bold),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 17,
                                        0)), // Cambia el color del borde cuando está enfocado
                              ),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              filled: true,
                              fillColor: Color.fromARGB(200, 22, 21, 21),
                              labelText: 'Apellidos',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                letterSpacing: 2,
                              ), // Cambia el color del texto del label a blanco
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Este campo es obligatorio *';
                              }
                              return null;
                            },
                            obscureText: false,
                          ),
                          SizedBox(height: 20.0),
                          TextFormField(
                            controller: controlertelefono,
                            cursorColor: Color.fromARGB(255, 255, 17, 0),
                            style: const TextStyle(
                              color: Colors.white,
                            ), // Cambia el color de texto a blanco
                            decoration: const InputDecoration(
                              errorStyle: TextStyle(
                              color: Color.fromARGB(255, 255, 255,
                                  255), // Personaliza el color del mensaje de error
                              fontStyle: FontStyle
                                  .italic, // Personaliza el estilo del mensaje de error
                              fontWeight: FontWeight.bold),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color.fromARGB(255, 255, 17,
                                        0)), // Cambia el color del borde cuando está enfocado
                              ),
                              border: OutlineInputBorder(borderSide: BorderSide()),
                              filled: true,
                              fillColor: Color.fromARGB(200, 22, 21, 21),
                              labelText: 'Telefono',
                              labelStyle: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w100,
                                letterSpacing: 2,
                              ), // Cambia el color del texto del label a blanco
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '* Este campo es obligatorio *';
                              }
                              return null;
                            },
                            obscureText: false,
                          ),
                          SizedBox(height: 40.0),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(
                                  255, 255, 17, 0), // Color de fondo rojo
                              borderRadius: BorderRadius.circular(
                                  10), // Bordes más cuadrados con radio de 10
                            ),
                            child: Material(
                              color: Colors.transparent,
                              child: InkWell(
                                onTap: () {
                                  if (_formKey.currentState!.validate()) {
                                    HacerRegistro(context);
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Center(
                                    child: Text(
                                      'CREAR CUENTA',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        letterSpacing: 7,
                                        color: Colors.white, // Color de texto blanco
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          TextButton(
                            onPressed: alHacerClick,
                            child: const Text(
                              '¿Ya tienes cuenta? Incia sesion',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
           Positioned(
            top: kToolbarHeight +
                -60, // Posiciona la línea roja debajo del AppBar
            left: 0,
            right: 0,
            child: Container(
              height: 6, // Altura de la línea roja
              color:
                  Color.fromARGB(255, 255, 255, 255), // Color de la línea roja
            ),
          ),
          Positioned(
            top: kToolbarHeight +
                -54, // Posiciona la línea roja debajo del AppBar
            left: 0,
            right: 0,
            child: Container(
              height: 3, // Altura de la línea roja
              color: Color.fromARGB(255, 255, 0, 0), // Color de la línea roja
            ),
          ),
        ],
      ),
    );
  }
}
