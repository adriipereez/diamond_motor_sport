import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:diamond_motor_sport/auth/servicio_auth.dart';

class SubirAnuncio extends StatefulWidget {
  @override
  _SubirAnuncioState createState() => _SubirAnuncioState();
}

final ServicioAuth servicioAuth = ServicioAuth();

class _SubirAnuncioState extends State<SubirAnuncio> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<String> tiposDeCoche = [
    'Sedan',
    'SUV',
    'Pickup',
    'Deportivo',
    'Familiar',
    'Compacto'
  ];

  String? _selectedTipoDeCoche;
  String? _selectedFuelType;
  TextEditingController _marcaController = TextEditingController();
  TextEditingController _modeloController = TextEditingController();
  TextEditingController _kmController = TextEditingController();
  TextEditingController _anyController = TextEditingController();
  TextEditingController _descripcionController = TextEditingController();
  bool _photoUploaded = false;
  XFile? _image;

  Future<void> _pickImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    XFile? pickedImage;

    try {
      pickedImage = await _picker.pickImage(source: source);
    } on PlatformException catch (e) {
      print('Error: $e');
    }

    if (pickedImage != null) {
      setState(() {
        _image = pickedImage;
        _photoUploaded = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        titleText: "Subir Anuncio",
      ),
      drawer: CustomDrawer(),
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/ferrari.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          color: const Color.fromARGB(255, 0, 0, 0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  'Subir Anuncio',
                                  style: GoogleFonts.novaMono(
                                    color: Colors.white,
                                    fontSize: 55,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _marcaController,
                                  decoration: const InputDecoration(
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                    labelText: 'Marca',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 2,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 255, 17, 0),
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    fillColor: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '* Este campo es obligatorio *';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _modeloController,
                                  decoration: const InputDecoration(
                                    labelText: 'Modelo',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 2,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 255, 17, 0),
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    fillColor: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '* Este campo es obligatorio *';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _kmController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(6),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Kilómetros',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 2,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 255, 17, 0),
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    fillColor: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '* Este campo es obligatorio *';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _anyController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    LengthLimitingTextInputFormatter(4),
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  decoration: const InputDecoration(
                                    labelText: 'Año',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 2,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 255, 17, 0),
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    fillColor: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '* Este campo es obligatorio *';
                                    }
                                    if (value.length != 4) {
                                      return '* El año debe tener 4 dígitos *';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                TextFormField(
                                  controller: _descripcionController,
                                  decoration: const InputDecoration(
                                    labelText: 'Descripción',
                                    labelStyle: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w100,
                                      letterSpacing: 2,
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: Color.fromARGB(255, 255, 17, 0),
                                      ),
                                    ),
                                    border: OutlineInputBorder(),
                                    fillColor: Color.fromARGB(255, 0, 0, 0),
                                  ),
                                  style: const TextStyle(color: Colors.white),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '* Este campo es obligatorio *';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                Container(
                                  width: double.infinity,
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 17, 0), // Color de fondo rojo
                                    borderRadius: BorderRadius.circular(
                                        10), // Bordes más cuadrados con radio de 10
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 20), // Separación entre columnas
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          color: const Color.fromARGB(255, 0, 0, 0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(30.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              SizedBox(height: 20.0),
                              ElevatedButton(
                                onPressed: () {
                                  _pickImage(ImageSource.gallery);
                                },
                                child: _photoUploaded
                                    ? Image.file(
                                        File(_image!.path),
                                        width: 100,
                                        height: 100,
                                        fit: BoxFit.cover,
                                      )
                                    : Text(
                                        'Subir foto',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                style: ElevatedButton.styleFrom(
                                  primary: Color.fromARGB(255, 255, 17, 0),
                                  elevation: 0,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 16, horizontal: 24),
                                ),
                              ),
                              SizedBox(height: 20.0),
                              DropdownButtonFormField<String>(
                                dropdownColor: Colors.black,
                                borderRadius: BorderRadius.circular(0),
                                value: _selectedTipoDeCoche,
                                icon: Icon(Icons.arrow_downward),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 16),
                                  labelText: 'Tipo de Coche',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 17, 0),
                                    ),
                                  ),
                                  border: OutlineInputBorder(),
                                  fillColor: Color.fromARGB(255, 0, 0, 0),
                                ),
                                style: TextStyle(color: Colors.white),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedTipoDeCoche = newValue;
                                  });
                                },
                                items:
                                    tiposDeCoche.map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    );
                                  },
                                ).toList(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '* Este campo es obligatorio *';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
                              DropdownButtonFormField<String>(
                                dropdownColor: Colors.black,
                                borderRadius: BorderRadius.circular(20),
                                value: _selectedFuelType,
                                icon: Icon(Icons.arrow_downward),
                                decoration: InputDecoration(
                                  labelText: 'Tipo de Combustible',
                                  labelStyle: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w100,
                                    letterSpacing: 2,
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 255, 17, 0),
                                    ),
                                  ),
                                  border: OutlineInputBorder(),
                                  fillColor: Color.fromARGB(255, 0, 0, 0),
                                ),
                                style: TextStyle(color: Colors.white),
                                onChanged: (String? newValue) {
                                  setState(() {
                                    _selectedFuelType = newValue;
                                  });
                                },
                                items: <String>[
                                  'Gasolina',
                                  'Diesel',
                                  'Eléctrico',
                                  'Híbrido'
                                ].map<DropdownMenuItem<String>>(
                                  (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    );
                                  },
                                ).toList(),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return '* Este campo es obligatorio *';
                                  }
                                  return null;
                                },
                              ),
                              SizedBox(height: 20.0),
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
                                    onTap: () async {
                                      // Obtener el UID del usuario actualmente autenticado
                                      String? uid = FirebaseAuth
                                          .instance.currentUser?.uid;

                                      if (uid != null) {
                                        String marca = _marcaController.text;
                                        String modelo = _modeloController.text;
                                        int km =
                                            int.tryParse(_kmController.text) ??
                                                0;
                                        int anyo =
                                            int.tryParse(_anyController.text) ??
                                                0;
                                        String descripcion =
                                            _descripcionController.text;

                                        if (marca.isNotEmpty &&
                                            modelo.isNotEmpty &&
                                            km > 0 &&
                                            anyo > 0 &&
                                            descripcion.isNotEmpty &&
                                            _selectedTipoDeCoche != null &&
                                            _selectedFuelType != null) {
                                          await servicioAuth.guardarAnuncio(
                                            uid, // Pasar el UID del usuario
                                            marca,
                                            modelo,
                                            km,
                                            anyo,
                                            descripcion,
                                            _selectedTipoDeCoche!,
                                            _selectedFuelType!,
                                          );

                                          _marcaController.clear();
                                          _modeloController.clear();
                                          _kmController.clear();
                                          _anyController.clear();
                                          _descripcionController.clear();
                                          _selectedTipoDeCoche = '';
                                          _selectedFuelType = '';

                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Anuncio guardado correctamente'),
                                              backgroundColor: Colors.green,
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                  'Por favor, completa todos los campos correctamente'),
                                              backgroundColor: Colors.red,
                                              duration: Duration(seconds: 3),
                                            ),
                                          );
                                        }
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content:
                                                Text('Usuario no autenticado'),
                                            backgroundColor: Colors.red,
                                            duration: Duration(seconds: 3),
                                          ),
                                        );
                                      }
                                    },
                                    child: Padding(
                                      padding: EdgeInsets.all(12.0),
                                      child: Center(
                                        child: Text(
                                          'PUBLICAR',
                                          style: TextStyle(
                                            fontStyle: FontStyle.italic,
                                            letterSpacing: 2,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 20,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
