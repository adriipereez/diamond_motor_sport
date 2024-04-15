import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

class GridAnuncios extends StatelessWidget {
  const GridAnuncios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text('Alquiler de Coches'),
      ),
      body: const Column(
        children: [
          FilterBanner(),
          Expanded(
            child: CarAdsGrid(),
          ),
        ],
      ),
    );
  }
}

class FilterBanner extends StatefulWidget {
  const FilterBanner({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _FilterBannerState createState() => _FilterBannerState();
}

class _FilterBannerState extends State<FilterBanner> {
  double _currentSliderValueYear = 1990;
  double _currentSliderValueKm = 500000;
  String? _selectedFuelType; // Tipo de combustible seleccionado

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: FractionallySizedBox(
            widthFactor: 0.75, // Ocupa un tercio del ancho disponible
            child: GestureDetector(
              onTap: () {
                // Lógica cuando se toca el banner de filtro
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Container(
                  height: 150, // Ajusta la altura según sea necesario
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
                        max: 999999,
                        divisions: 64,
                        label: _currentSliderValueKm.round().toString(),
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
        ),
        Expanded(
          child: FractionallySizedBox(
            widthFactor: 0.75, // Ocupa un tercio del ancho disponible
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 150, // Ajusta la altura según sea necesario
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
                      dropdownColor: Colors
                          .black, // Establecer el color de fondo del desplegable
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
                            style: const TextStyle(
                                color: Colors
                                    .white), // Establecer el color del texto en blanco
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
        Expanded(
          child: FractionallySizedBox(
            widthFactor: 0.75, // Ocupa un tercio del ancho disponible
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 150, // Ajusta la altura según sea necesario
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      'Filtrar por año: ${_currentSliderValueYear.toInt()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Slider(
                      value: _currentSliderValueYear,
                      min: 1960,
                      max: 2024,
                      divisions: 64,
                      label: _currentSliderValueYear.round().toString(),
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValueYear = value;
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class CarAdsGrid extends StatelessWidget {
  const CarAdsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double maxWidth = constraints.maxWidth;
        int columns = (maxWidth > 768) ? 4 : 2;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 8.0,
              mainAxisSpacing: 8.0,
            ),
            itemCount: 8, // Número de coches en la base de datos
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  // Lógica cuando se toca el anuncio de coche
                },
                child: const CarAdWidget(),
              );
            },
          ),
        );
      },
    );
  }
}

class CarAdWidget extends StatelessWidget {
  const CarAdWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: const Column(
        children: [
          // Mostrar la información del coche
          // (imagen, detalles, etc.)
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: GridAnuncios(),
  ));
}
