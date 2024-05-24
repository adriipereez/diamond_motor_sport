import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:diamond_motor_sport/componentes/footer.dart';
import 'package:flutter/material.dart';

class PoliticasDePrivacidad extends StatelessWidget {
  const PoliticasDePrivacidad({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(),
      body: Container(
        color: Colors.black, // Fondo negro
        child: const Column(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Políticas de Privacidad',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Introducción',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'En Diamond Motor Sport, valoramos su privacidad y estamos comprometidos a proteger sus datos personales. Esta política de privacidad describe cómo recopilamos, usamos y protegemos su información personal.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Recopilación de Datos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Recopilamos información personal que usted nos proporciona directamente, como su nombre, dirección de correo electrónico, número de teléfono y cualquier otra información que decida proporcionarnos. También podemos recopilar información sobre su uso de nuestro sitio web mediante cookies y tecnologías similares.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Uso de los Datos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Utilizamos su información personal para proporcionar y mejorar nuestros servicios, comunicarnos con usted, personalizar su experiencia en nuestro sitio web y cumplir con nuestras obligaciones legales.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Compartición de los Datos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'No compartimos su información personal con terceros, excepto según lo requerido por la ley o para proporcionar nuestros servicios. Podemos compartir información con nuestros proveedores de servicios que nos ayudan a operar nuestro negocio, siempre que dichos proveedores acepten mantener la confidencialidad de su información.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Seguridad de los Datos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Implementamos medidas de seguridad adecuadas para proteger su información personal contra el acceso no autorizado, la alteración, divulgación o destrucción.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Sus Derechos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Usted tiene derecho a acceder, rectificar, eliminar y oponerse al tratamiento de sus datos personales, así como a limitar su uso. Para ejercer estos derechos, por favor póngase en contacto con nosotros a través de la información proporcionada al final de esta política.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Cambios en la Política de Privacidad',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Podemos actualizar esta política de privacidad de vez en cuando. Publicaremos cualquier cambio en esta página y, si los cambios son significativos, proporcionaremos un aviso más destacado.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Contacto',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Si tiene alguna pregunta sobre esta política de privacidad, puede ponerse en contacto con nosotros a través del correo electrónico info@diamondmotorsport.com.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Divider(color: Colors.white),
            Footer(),
          ],
        ),
      ),
    );
  }
}
