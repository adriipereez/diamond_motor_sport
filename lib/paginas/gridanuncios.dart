import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:diamond_motor_sport/paginas/paginaCoches.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class GridAnuncios extends StatelessWidget {
  final ServicioAuth servicioAuth = ServicioAuth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          FilterBanner(),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: servicioAuth.obtenerAnunciosConDocumentos(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else {
                  List<Map<String, dynamic>> anuncios = snapshot.data ?? [];
                  return CarAdsGrid(anuncios: anuncios);
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}

class FilterBanner extends StatefulWidget {
  const FilterBanner({Key? key}) : super(key: key);

  @override
  _FilterBannerState createState() => _FilterBannerState();
}

class _FilterBannerState extends State<FilterBanner> {
  double _currentSliderValueKm = 1000000;
  String? _selectedFuelType;
  double _currentSliderValueMaxYear = 2024;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Filtrar por km: ${_currentSliderValueKm.toInt()}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Slider(
                          value: _currentSliderValueKm,
                          min: 0,
                          max: 1000000,
                          divisions: 64,
                          label: _currentSliderValueKm.round().toString(),
                          activeColor: Colors.red,
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValueKm = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'Año máximo: ${_currentSliderValueMaxYear.toInt()}',
                          style: const TextStyle(color: Colors.white),
                        ),
                        Slider(
                          value: _currentSliderValueMaxYear,
                          min: 1920,
                          max: 2024,
                          divisions: 64,
                          label: _currentSliderValueMaxYear.round().toString(),
                          activeColor: Colors.red,
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValueMaxYear = value;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FractionallySizedBox(
                widthFactor: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Container(
                    height: 150,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        const Text('Seleccionar tipo de combustible:',
                            style: TextStyle(color: Colors.white)),
                        DropdownButton<String>(
                          value: _selectedFuelType,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedFuelType = newValue;
                            });
                          },
                          dropdownColor: Colors.black,
                          items: <String>[
                            'Gasolina',
                            'Diesel',
                            'Eléctrico',
                            'Híbrido'
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16),
      ],
    );
  }
}

class CarAdsGrid extends StatelessWidget {
  final List<Map<String, dynamic>> anuncios;

  const CarAdsGrid({Key? key, required this.anuncios}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        int columns = (maxWidth > 1500)
            ? 4
            : (maxWidth > 960)
                ? 3
                : 2;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List<String>>(
            future: _getImagesUrls(anuncios),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else {
                List<String> imageUrls = snapshot.data ?? [];
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: columns,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  itemCount: anuncios.length,
                  itemBuilder: (BuildContext context, int index) {
                    final anuncio = anuncios[index];
                    final documentName = anuncio['nombreDocumento'] as String;
                    final imageUrl = imageUrls[index];

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => AnuncioDetallePage(
                              anuncio: anuncio,
                              imageUrl: imageUrl,
                            ),
                          ),
                        );
                      },
                      child: CarAdWidget(
                        make: anuncio['marca'],
                        model: anuncio['modelo'],
                        year: anuncio['any'].toString(),
                        mileage: anuncio['km'].toString(),
                        fuelType: anuncio['tipoCombustible'],
                        imageUrl: imageUrl,
                      ),
                    );
                  },
                );
              }
            },
          ),
        );
      },
    );
  }

  Future<List<String>> _getImagesUrls(List<Map<String, dynamic>> anuncios) async {
    List<String> imageUrls = [];
    for (var anuncio in anuncios) {
      String documentName = anuncio['nombreDocumento'] as String;
      try {
        String imageUrl = await FirebaseStorage.instance
            .ref('/$documentName/imagen/$documentName')
            .getDownloadURL();
        imageUrls.add(imageUrl);
      } catch (e) {
        print('Error al obtener la URL de la imagen: $e');
        imageUrls.add('');
      }
    }
    return imageUrls;
  }
}

class CarAdWidget extends StatelessWidget {
  final String make;
  final String model;
  final String year;
  final String mileage;
  final String fuelType;
  final String imageUrl;

  const CarAdWidget({
    Key? key,
    required this.make,
    required this.model,
    required this.year,
    required this.mileage,
    required this.fuelType,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.black,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              child: Container(
                width: double.infinity,
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$make $model',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  'Año: $year',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  'Km: $mileage',
                  style: TextStyle(color: Colors.white),
                ),
                SizedBox(height: 4),
                Text(
                  'Combustible: $fuelType',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
