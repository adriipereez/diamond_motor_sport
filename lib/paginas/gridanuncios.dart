import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:flutter/material.dart';

class GridAnuncios extends StatelessWidget {
  const GridAnuncios({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(),
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
  const FilterBanner({Key? key}) : super(key: key);

  @override
  _FilterBannerState createState() => _FilterBannerState();
}

class _FilterBannerState extends State<FilterBanner> {
  double _currentSliderValueKm = 1000000;
  String? _selectedFuelType;
  double _currentSliderValueMaxYear = 2024;
  double _currentSliderValueMinYear = 1960;

  void resetFilters() {
    setState(() {
      _currentSliderValueKm = 1000000;
      _selectedFuelType = null;
      _currentSliderValueMaxYear = 2024;
      _currentSliderValueMinYear = 1960;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FractionallySizedBox(
            widthFactor: 0.75,
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
            widthFactor: 0.75,
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
                      'Año mínimo: ${_currentSliderValueMinYear.toInt()}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    Slider(
                      value: _currentSliderValueMinYear,
                      min: 1960,
                      max: 2024,
                      divisions: 64,
                      label: _currentSliderValueMinYear.round().toString(),
                      activeColor: Colors.red,
                      onChanged: (double value) {
                        setState(() {
                          _currentSliderValueMinYear = value;
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
            widthFactor: 0.75,
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
                      min: 1960,
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
            widthFactor: 0.75,
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
        Expanded(
          child: FractionallySizedBox(
            widthFactor: 0.85,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Container(
                height: 150,
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: resetFilters,
                        child: const Text(
                          'Borrar filtro',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          minimumSize: const Size(double.infinity, 50),
                        ),
                        onPressed: () {},
                        child: const Text(
                          'Filtrar',
                          style: TextStyle(
                            color: Colors.white,
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
      ],
    );
  }
}

class CarAdsGrid extends StatelessWidget {
  const CarAdsGrid({Key? key}) : super(key: key);

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
            itemCount: 8,
            itemBuilder: (BuildContext context, int index) {
              // Simulando datos únicos para cada anuncio
              final carMake = '$index';
              final carModel = '$index';
              final carYear = '${index % 10}';
              final carMileage = 'Km';
              final carFuelType = index % 4 == 0
                  ? 'Gasolina'
                  : index % 4 == 1
                      ? 'Diesel'
                      : index % 4 == 2
                          ? 'Eléctrico'
                          : 'Híbrido';

              return GestureDetector(
                onTap: () {},
                child: CarAdWidget(
                  make: carMake,
                  model: carModel,
                  year: carYear,
                  mileage: carMileage,
                  fuelType: carFuelType,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class CarAdWidget extends StatelessWidget {
  final String make;
  final String model;
  final String year;
  final String mileage;
  final String fuelType;

  const CarAdWidget({
    Key? key,
    required this.make,
    required this.model,
    required this.year,
    required this.mileage,
    required this.fuelType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(8.0),
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                make,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 8),
              Text(
                model,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 8),
              Text(
                year,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                mileage,
                style: const TextStyle(fontSize: 24),
              ),
              const SizedBox(width: 8),
              Text(
                fuelType,
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
