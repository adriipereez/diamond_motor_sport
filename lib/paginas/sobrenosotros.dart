import 'package:flutter/material.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:flutter/widgets.dart';

class SobreNosotros extends StatelessWidget {
  const SobreNosotros({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: LayoutBuilder(
              builder: (context, constraints) {
                if (constraints.maxWidth > 600) {
                  // Para anchos de pantalla mayores a 600px (por ejemplo, tablets y desktops)
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        children: [
                          Image.asset(
                            'assets/garaje1.jpg',
                            width: constraints.maxWidth * 0.6,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(height: 20),
                          Image.asset(
                            'assets/garaje2.jpg',
                            width: constraints.maxWidth * 0.6,
                            height: 400,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _buildTexts(),
                        ),
                      ),
                    ],
                  );
                } else {
                  // Para anchos de pantalla menores o iguales a 600px (por ejemplo, dispositivos móviles)
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/garaje1.jpg',
                        width: constraints.maxWidth,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 20),
                      Image.asset(
                        'assets/garaje2.jpg',
                        width: constraints.maxWidth,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.2),
                        child: Column(
                          children: _buildTexts(),
                        ),
                      ),
                    ],
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildTexts() {
    return [
      const Padding(
        padding: EdgeInsets.only(bottom: 20), // Ajusta el espacio inferior
        child: Text(
          'Bienvenido a Diamond Motor Sport',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      const Padding(
        padding: EdgeInsets.only(bottom: 20), // Ajusta el espacio inferior
        child: Text(
          'Diamond Motor Sport es una plataforma de compra y venta de vehículos de motor. Permitimos a los usuarios vender sus vehículos a otros usuarios interesados, proporcionando una amplia gama de opciones y un servicio excepcional. Nuestra misión es proporcionar una plataforma confiable y conveniente para que los entusiastas y profesionales puedan comprar y vender vehículos de motor de manera segura y eficiente, asegurando la satisfacción del cliente en todo momento.',
          style: TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
      const SizedBox(height: 20),
      const Text(
        '¿Quieres comprarte el coche de tus sueños?',
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      const Text(
        'Sabemos que lo estás buscando, en nuestra web te ofrecemos la posibilidad de hacer tus sueños realidad, para que dejes de pensar en ello y te lances.',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      const Text(
        'Esa es una de las razones por las que estamos aquí, queremos que cumplas tus sueños y lo hagas de la mejor forma.',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
      const SizedBox(height: 20),
      const Text(
        '¿O estás buscando vender tu coche?',
        style: TextStyle(
          fontSize: 22,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      const Text(
        'No te preocupes, tenemos la red de compra venta más activa, sube, queda, vende, y en ese momento puedes volver a entrar para elevar el nivel y comprar el siguiente coche de tus sueños.',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    ];
  }
}

void main() {
  runApp(const MaterialApp(
    home: SobreNosotros(),
  ));
}
