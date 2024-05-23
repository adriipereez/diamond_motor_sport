import 'dart:io';
import 'package:diamond_motor_sport/componentes/drawerrouter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
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
  File? _imagenSeleccionadaApp;
  Uint8List? _imagenSeleccionadaWeb;
  bool _imagenAPuntoParaSubir = false;

  Future<void> _escogeImagen() async {
    final ImagePicker picker = ImagePicker();
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      if (!kIsWeb) {
        File archivoSeleccionado = File(image.path);

        setState(() {
          _imagenSeleccionadaApp = archivoSeleccionado;
          _imagenAPuntoParaSubir = true;
        });
      }

      if (kIsWeb) {
        Uint8List archivoEnBytes = await image.readAsBytes();

        setState(() {
          _imagenSeleccionadaWeb = archivoEnBytes;
          _imagenAPuntoParaSubir = true;
        });
      }
    }
  }

  Future<bool> pujarImatgePerUsuari(String idDocument) async {
    Reference ref =
        FirebaseStorage.instance.ref().child("$idDocument/imagen/$idDocument");

    try {
      if (_imagenSeleccionadaApp != null) {
        await ref.putFile(_imagenSeleccionadaApp!);
      } else if (_imagenSeleccionadaWeb != null) {
        await ref.putData(_imagenSeleccionadaWeb!);
      } else {
        return false; // No se ha seleccionado una imagen
      }

      return true;
    } catch (e) {
      return false;
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
                                  child: DropdownButtonFormField<String>(
                                    dropdownColor: Colors
                                        .black, // Color del menú desplegable
                                    value: _selectedFuelType,
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedFuelType = newValue;
                                      });
                                    },
                                    decoration: const InputDecoration(
                                      labelText: 'Tipo de combustible',
                                      labelStyle: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w100,
                                        letterSpacing: 2,
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderSide: BorderSide(
                                          color:
                                              Color.fromARGB(255, 255, 17, 0),
                                        ),
                                      ),
                                      border: OutlineInputBorder(),
                                      fillColor: Color.fromARGB(255, 0, 0, 0),
                                    ),
                                    style: const TextStyle(
                                        color: Colors
                                            .white), // Color del texto blanco
                                    items: <String>[
                                      'Gasolina',
                                      'Diésel',
                                      'Eléctrico',
                                      'Híbrido'
                                    ].map<DropdownMenuItem<String>>(
                                        (String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '* Este campo es obligatorio *';
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                DropdownButtonFormField<String>(
                                  dropdownColor: Colors.black,
                                  value: _selectedTipoDeCoche,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _selectedTipoDeCoche = newValue;
                                    });
                                  },
                                  decoration: const InputDecoration(
                                    labelText: 'Tipo de coche',
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
                                  items: tiposDeCoche
                                      .map<DropdownMenuItem<String>>(
                                          (String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '* Este campo es obligatorio *';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 20.0),
                                GestureDetector(
                                  onTap: _escogeImagen,
                                  child: Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(
                                          255, 0, 0, 0), // Fondo negro
                                      border: Border.all(
                                          color: Colors.white), // Borde blanco
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: _imagenSeleccionadaApp != null
                                        ? Image.file(
                                            _imagenSeleccionadaApp!,
                                            fit: BoxFit.cover,
                                          )
                                        : _imagenSeleccionadaWeb != null
                                            ? Image.memory(
                                                _imagenSeleccionadaWeb!,
                                                fit: BoxFit.cover,
                                              )
                                            : const Center(
                                                child: Text(
                                                  'Subir imagen',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                              ),
                                  ),
                                ),
                                const SizedBox(height: 20.0),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: const Color.fromARGB(
                                        255, 255, 17, 0), // Fondo rojo
                                    onPrimary: Colors.white, // Texto blanco
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  onPressed: () async {
                                    if (_formKey.currentState!.validate()) {
                                      String idDocument = "ID_DEL_DOCUMENTO";
                                      bool imagenSubida =
                                          await pujarImatgePerUsuari(
                                              idDocument);

                                      if (imagenSubida) {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Anuncio subido correctamente'),
                                          ),
                                        );
                                      } else {
                                        ScaffoldMessenger.of(context)
                                            .showSnackBar(
                                          SnackBar(
                                            content: Text(
                                                'Error al subir la imagen'),
                                          ),
                                        );
                                      }
                                    }
                                  },
                                  child: Text(
                                    'Subir Anuncio',
                                    style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 40.0), // Espacio horizontal entre columnas
                    Expanded(
                      flex: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white, width: 3),
                          color: Color.fromARGB(255, 0, 0, 0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            SizedBox(
                                height:
                                    20.0), // Espacio entre columna y borde superior
                            Icon(Icons.directions_car,
                                size: 100, color: Colors.white),
                            SizedBox(height: 20.0),
                            Text(
                              'Detalles del coche',
                              style: GoogleFonts.novaMono(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Marca: ${_marcaController.text}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Modelo: ${_modeloController.text}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Kilómetros: ${_kmController.text}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Año: ${_anyController.text}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Descripción: ${_descripcionController.text}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Combustible: ${_selectedFuelType ?? ''}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                  Text(
                                    'Tipo de coche: ${_selectedTipoDeCoche ?? ''}',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
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
