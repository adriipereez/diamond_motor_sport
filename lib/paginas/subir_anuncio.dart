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
import 'package:firebase_auth/firebase_auth.dart';

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
  TextEditingController _precioController = TextEditingController();
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
                padding: const EdgeInsets.only(
                    top: 75, right: 400, left: 400, bottom: 100),
                child: Expanded(
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
                            const SizedBox(height: 20.0),
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
                            const SizedBox(height: 20.0),
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
                                int year;
                                try {
                                  year = int.parse(value);
                                } catch (e) {
                                  return '* El valor ingresado no es un número válido *';
                                }
                                if (year < 1950 || year > 2024) {
                                  return '* El año debe estar entre 1950 y 2024 *';
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
                              maxLines: 3,
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
                            const SizedBox(height: 10.0),
                            DropdownButtonFormField<String>(
                              dropdownColor: Colors.black,
                              borderRadius: BorderRadius.circular(0),
                              value: _selectedTipoDeCoche,
                              icon: const Icon(Icons.arrow_downward),
                              decoration: const InputDecoration(
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
                              style: const TextStyle(color: Colors.white),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedTipoDeCoche = newValue;
                                });
                              },
                              items: tiposDeCoche.map<DropdownMenuItem<String>>(
                                (String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
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
                            const SizedBox(height: 20.0),
                            DropdownButtonFormField<String>(
                              dropdownColor: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                              value: _selectedFuelType,
                              icon: const Icon(Icons.arrow_downward),
                              decoration: const InputDecoration(
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
                            GestureDetector(
                              onTap: _escogeImagen,
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      10), // Bordes redondeados
                                  color: const Color.fromARGB(255, 255, 17, 0),
                                ),
                                child: const Text(
                                  "Escoge una imagen",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              child: _imagenSeleccionadaWeb == null &&
                                      _imagenSeleccionadaApp == null
                                  ? Container(
                                      child: TextFormField(
                                        validator: (value) {
                                          if (_imagenSeleccionadaWeb == null &&
                                              _imagenSeleccionadaApp == null) {
                                            return '* Debes seleccionar una imagen *';
                                          }
                                          return null;
                                        },
                                        enabled: false,
                                      ),
                                    )
                                  : kIsWeb
                                      ? SizedBox(
                                          width:
                                              600, // Establece el ancho deseado
                                          height:
                                              400, // Establece la altura deseada
                                          child: Image.memory(
                                            _imagenSeleccionadaWeb!,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : SizedBox(
                                          width:
                                              200, // Establece el ancho deseado
                                          height:
                                              200, // Establece la altura deseada
                                          child: Image.file(
                                            _imagenSeleccionadaApp!,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                            ),
                            const SizedBox(height: 20.0),
                            TextFormField(
                              controller: _precioController,
                              decoration: const InputDecoration(
                                labelText: 'Precio',
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
                                prefixText: '€ ', 
                                prefixStyle: TextStyle(
                                    color: Colors.white),
                              ),
                              style: TextStyle(color: Colors.white),
                              keyboardType: TextInputType.numberWithOptions(
                                  decimal: true),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return '* Este campo es obligatorio *';
                                }
                                if (double.tryParse(value) == null) {
                                  return '* Ingrese un número válido *';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
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
                                    if (!_imagenAPuntoParaSubir) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                              'Por favor, completa todos los campos correctamente'),
                                          backgroundColor: Colors.red,
                                          duration: Duration(seconds: 3),
                                        ),
                                      );
                                      return;
                                    }

                                    String marca = _marcaController.text;
                                    String modelo = _modeloController.text;
                                    int km =
                                        int.tryParse(_kmController.text) ?? 0;
                                    int anyo =
                                        int.tryParse(_anyController.text) ?? 0;
                                    String descripcion =
                                        _descripcionController.text;
                                    double precio = double.tryParse(
                                            _precioController.text) ??
                                        0.0; // Obtener el precio del campo

                                    if (marca.isNotEmpty &&
                                        modelo.isNotEmpty &&
                                        km > 0 &&
                                        anyo >= 1950 &&
                                        anyo <= 2024 &&
                                        descripcion.isNotEmpty &&
                                        _selectedTipoDeCoche != null &&
                                        _selectedFuelType != null) {
                                      String currentUserId = FirebaseAuth
                                          .instance.currentUser!.uid;

                                      String idDocument =
                                          await servicioAuth.guardarAnuncio(
                                        marca,
                                        modelo,
                                        km,
                                        anyo,
                                        descripcion,
                                        _selectedTipoDeCoche!,
                                        _selectedFuelType!,
                                        precio, // Pasar el precio al guardarAnuncio()
                                        currentUserId,
                                      );

                                      if (_imagenAPuntoParaSubir) {
                                        bool imageSubidaCorrectamente =
                                            await pujarImatgePerUsuari(
                                                idDocument);
                                        Navigator.pushReplacementNamed(
                                            context, DrawerRoutes.principal1);
                                        if (!imageSubidaCorrectamente) {
                                          print("Error al subir la imagen");
                                        }
                                      }

                                      _marcaController.clear();
                                      _modeloController.clear();
                                      _kmController.clear();
                                      _anyController.clear();
                                      _descripcionController.clear();
                                      _precioController
                                          .clear(); // Limpiar el campo de precio
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
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
