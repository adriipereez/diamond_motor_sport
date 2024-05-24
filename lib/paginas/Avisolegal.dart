import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:diamond_motor_sport/componentes/footer.dart';
import 'package:flutter/material.dart';

class AvisoLegal extends StatelessWidget {
  const AvisoLegal({super.key});

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
                        'Aviso Legal',
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
                        'Este aviso legal regula el uso del sitio web de compra y venta de coches Diamond Motor Sport. Al acceder y utilizar este sitio web, usted acepta los términos y condiciones establecidos en este aviso legal.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Propiedad Intelectual',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Todos los contenidos del sitio web, incluyendo pero no limitándose a textos, gráficos, imágenes, logotipos y software, son propiedad de Diamond Motor Sport o de sus licenciantes y están protegidos por las leyes de propiedad intelectual. Queda prohibida la reproducción, distribución, o comunicación pública, total o parcial, de los contenidos de esta web sin la autorización expresa de Diamond Motor Sport.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Condiciones de Uso',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'El usuario se compromete a hacer un uso adecuado de los contenidos y servicios que Diamond Motor Sport ofrece a través de su sitio web y a no emplearlos para incurrir en actividades ilícitas, ilegales o contrarias a la buena fe y al orden público. Asimismo, el usuario se compromete a no causar daños en los sistemas físicos y lógicos de Diamond Motor Sport, de sus proveedores o de terceras personas.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Protección de Datos',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Diamond Motor Sport se compromete a la protección de los datos personales de los usuarios de su sitio web y a su tratamiento conforme a la legislación vigente en materia de protección de datos. Para más información, consulte nuestra Política de Privacidad.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Enlaces a Terceros',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'En el caso de que en el sitio web se dispusieran enlaces o hipervínculos hacía otros sitios de Internet, Diamond Motor Sport no ejercerá ningún tipo de control sobre dichos sitios y contenidos. En ningún caso Diamond Motor Sport asumirá responsabilidad alguna por los contenidos de algún enlace perteneciente a un sitio web ajeno.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Modificaciones del Aviso Legal',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Diamond Motor Sport se reserva el derecho a realizar modificaciones en el presente aviso legal, así como en cualquier otro contenido de su sitio web. Las modificaciones entrarán en vigor desde el momento de su publicación en el sitio web.',
                        textAlign: TextAlign.justify,
                        style: TextStyle(color: Colors.white), // Letras blancas
                      ),
                      SizedBox(height: 16),
                      Text(
                        'Legislación y Jurisdicción Aplicable',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Letras blancas
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'La relación entre Diamond Motor Sport y el usuario se regirá por la normativa vigente y cualquier controversia se someterá a los Juzgados y tribunales de la ciudad de Barcelona, salvo que la legislación aplicable disponga otra cosa.',
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
                        'Si tiene alguna pregunta sobre este aviso legal, puede ponerse en contacto con nosotros a través del correo electrónico info@diamondmotorsport.com.',
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
