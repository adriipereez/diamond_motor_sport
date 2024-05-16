import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:flutter/material.dart';

class AnuncioDetallePage extends StatelessWidget {
  final Map<String, dynamic> anuncio;
  final String imageUrl;

  AnuncioDetallePage({required this.anuncio, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(),
      drawer: CustomDrawer(),
      backgroundColor: Colors.black,
      body: LayoutBuilder(
        builder: (context, constraints) {
          final double screenHeight = constraints.maxHeight;
          final double screenWidth = constraints.maxWidth;

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: screenWidth * 0.6,
                  height: screenHeight * 0.9,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Marca: ${anuncio['marca']}',
                        style: TextStyle(fontSize: 40, color: Colors.white),
                      ),
                      Text(
                        'Modelo: ${anuncio['modelo']}',
                        style: TextStyle(fontSize: 35, color: Colors.white),
                      ),
                      Text(
                        'Año: ${anuncio['any']}',
                        style: TextStyle(fontSize: 30, color: Colors.white),
                      ),
                      Text(
                        '${anuncio['km']} km',
                        style: TextStyle(fontSize: 25, color: Colors.white),
                      ),
                      Text(
                        '${anuncio['tipoCombustible']}',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                      const SizedBox(height: 32),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            primary: Colors.red, // Color del botón
                            onPrimary:
                                Colors.white, // Color del texto del botón
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16.0),
                            child: Text(
                              'Contactar',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
