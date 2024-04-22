import 'package:flutter/material.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:flutter/widgets.dart';
import 'dart:async';

class SobreNosotros extends StatelessWidget {
  const SobreNosotros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Text(
                      'Quiénes Somos',
                      style: TextStyle(
                        fontSize: 44,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SingleChildScrollView(
                    child: Text(
                      'Diamond Motor Sport es una plataforma de compra y venta de vehículos de motor. Permitimos a los usuarios vender sus vehículos a otros usuarios interesados, proporcionando una amplia gama de opciones y un servicio excepcional. Nuestra misión es proporcionar una plataforma confiable y conveniente para que los entusiastas y profesionales puedan comprar y vender vehículos de motor de manera segura y eficiente, asegurando la satisfacción del cliente en todo momento.',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Espacio entre los elementos
              Container(
                padding: const EdgeInsets.all(8),
                height: 550, // Altura deseada
                width: MediaQuery.of(context).size.width * 0.8, // Ancho del 80% de la pantalla
                child: const ImageSlider(
                  imageUrls: [
                    'assets/image1.jpg',
                    'assets/image2.jpg',
                    'assets/main1.jpg',
                    'assets/image4.jpg',
                    'assets/image3.jpg',
                  ],
                ),
              ),
              SizedBox(height: 24),
              Text(
                'Contáctanos',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Para consultas o asistencia, no dudes en ponerte en contacto con nosotros en:',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Correo electrónico: info@diamondmotorsport.com\nTeléfono: +1234567890',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageSlider extends StatefulWidget {
  final List<String> imageUrls;

  const ImageSlider({Key? key, required this.imageUrls}) : super(key: key);

  @override
  _ImageSliderState createState() => _ImageSliderState();
}

class _ImageSliderState extends State<ImageSlider> {
  late PageController _pageController;
  int _currentPage = 0;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: _currentPage);
    _startTimer();
  }

  @override
  void dispose() {
    _pageController.dispose();
    _timer.cancel();
    super.dispose();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      if (_currentPage < widget.imageUrls.length - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        PageView.builder(
          itemCount: widget.imageUrls.length,
          controller: _pageController,
          onPageChanged: (index) {
            setState(() {
              _currentPage = index;
            });
          },
          itemBuilder: (context, index) {
            return Image.network(
              widget.imageUrls[index],
              fit: BoxFit.cover,
            );
          },
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: Colors.white,
            onPressed: () {
              if (_currentPage > 0) {
                _pageController.previousPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            color: Colors.white,
            onPressed: () {
              if (_currentPage < widget.imageUrls.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: SobreNosotros(),
  ));
}
