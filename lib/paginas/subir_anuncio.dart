import 'package:flutter/material.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class SubirAnuncio extends StatefulWidget {
  @override
  _SubirAnuncioState createState() => _SubirAnuncioState();
}

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(
        titleText: "Subir Anuncio",
      ),
      drawer: const CustomDrawer(),
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
                child: Container(
                  height: 800,
                  width: 600,
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
                            style: const TextStyle(color: Colors.white),
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
                                    style: const TextStyle(color: Colors.white),
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
                                    // Aquí iría la lógica para publicar el anuncio
                                  }
                                },
                                child: const Padding(
                                  padding: EdgeInsets.all(12.0),
                                  child: Center(
                                    child: Text(
                                      'PUBLICAR',
                                      style: TextStyle(
                                        fontStyle: FontStyle.italic,
                                        letterSpacing: 7,
                                        color: Colors
                                            .white, // Color de texto blanco
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
        ],
      ),
    );
  }
}
