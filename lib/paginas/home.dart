import 'dart:async';
import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:diamond_motor_sport/componentes/customTextField.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:diamond_motor_sport/componentes/drawerrouter.dart';
import 'package:diamond_motor_sport/paginas/gridanuncios.dart';
import 'package:diamond_motor_sport/paginas/sobrenosotros.dart';
import 'package:diamond_motor_sport/componentes/footer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';
import 'package:diamond_motor_sport/paginas/subir_anuncio.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final ServicioAuth _servicioAuth = ServicioAuth();
  User? _currentUser;
  late VideoPlayerController _controller;
  List<Map<String, dynamic>> _anuncios = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _currentUser = _servicioAuth.getUsuarioActual();
    _fetchAnuncios();
    _controller = VideoPlayerController.asset('assets/mainvideo.mp4')
      ..initialize().then((_) {
        _controller.play();
        _controller.setLooping(true);
        _controller.setVolume(0.0);
        setState(() {});
      });
  }

  Future<void> _fetchAnuncios() async {
    try {
      _anuncios = await _servicioAuth.obtenerAnunciosConDocumentos();
      setState(() {
        _isLoading = false;
      });
    } catch (e) {
      print('Error al obtener anuncios: $e');
    }
  }

  void _cerrarSesion() async {
    await _servicioAuth.cerrarsesion();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final crossAxisCount = screenWidth < 600
        ? 2
        : 4; // Ajusta el número de columnas según el ancho de la pantalla

    return Scaffold(
      appBar: CustomAppBar(showBottomLine: true),
      drawer: CustomDrawer(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                _controller.value.isInitialized
                    ? AspectRatio(
                        aspectRatio: _controller.value.aspectRatio,
                        child: VideoPlayer(_controller),
                      )
                    : Container(
                        height: MediaQuery.of(context).size.height,
                        color: Colors.black,
                      ),
                Positioned(
                  top: MediaQuery.of(context).size.height * 0.45,
                  left: MediaQuery.of(context).size.width * 0.05,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          'Compra y vende los mejores coches de lujo',
                          style: GoogleFonts.kanit(
                            color: Colors.white,
                            fontSize: 35.0,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GridAnuncios(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: Text(
                          'Explorar',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SobreNosotros(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                        child: const Text(
                          'Sobre nosotros',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            // Resto del código del Drawer
                            if (_servicioAuth.isLoggedIn)
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => SubirAnuncio(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                ),
                                child: const Text(
                                  'Subir anuncio',
                                  style: TextStyle(
                                      fontSize: 20, color: Colors.white),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 25.0),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  if (_isLoading)
                    CircularProgressIndicator()
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: crossAxisCount,
                        childAspectRatio: 1.5,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: _anuncios.length > 4 ? 4 : _anuncios.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GridAnuncios(),
                              ),
                            );
                          },
                          child: _buildAnuncioCard(_anuncios[index]),
                        );
                      },
                    ),
                  SizedBox(height: 25),
                  ImageWithTextSlider(
                    imagePath: 'assets/main1.jpg',
                    textAlignment: Alignment.center,
                  ),
                  SizedBox(height: 25.0),
                  ContactForm(),
                  Divider(),
                  Footer(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAnuncioCard(Map<String, dynamic> anuncio) {
    String documentName = anuncio['nombreDocumento'];
    String imageUrl = '/$documentName/imagen/$documentName';

    return FutureBuilder<String>(
      future: FirebaseStorage.instance.ref(imageUrl).getDownloadURL(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error al cargar la imagen'));
        } else {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.white), // Borde blanco
              borderRadius: BorderRadius.circular(8.0), // Bordes redondeados
            ),
            child: Card(
              color: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(8.0),
                    ),
                    child: Image.network(
                      snapshot.data!,
                      fit: BoxFit.cover, // Ajuste de la imagen
                      height:
                          195, // Altura de la imagen igual a la altura de la tarjeta
                      width: double
                          .infinity, // Asegura que la imagen ocupe todo el ancho
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${anuncio['marca']} ${anuncio['modelo']}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          '${anuncio['any']}',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '${anuncio['km']} km',
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 2),
                        Text(
                          '${anuncio['precio']} €',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        }
      },
    );
  }
}

class ImageWithTextSlider extends StatefulWidget {
  final String imagePath;
  final Alignment textAlignment;

  const ImageWithTextSlider({
    required this.imagePath,
    required this.textAlignment,
    Key? key,
  }) : super(key: key);

  @override
  _ImageWithTextSliderState createState() => _ImageWithTextSliderState();
}

class _ImageWithTextSliderState extends State<ImageWithTextSlider> {
  int _currentIndex = 0;
  late Timer _timer;

  final List<String> _userList = [
    'Rafael Nadal',
    'Neymar Jr',
    'Angel Muñoz García',
  ];

  final List<String> _reviewList = [
    '"Se toman muy en serio la experiencia del comprador y la atención al cliente es inmediata, da gusto comprar en esta página."',
    '"Excelente servicio al cliente y proceso de compra fácil y rápido."',
    '"El vehículo que compré estaba en perfectas condiciones, tal como se describía en el anuncio."',
  ];

  final List<String> _userOccupationList = [
    'Tenista',
    'Futbolista',
    'Actor',
  ];

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 4), (Timer timer) {
      setState(() {
        _currentIndex = (_currentIndex + 1) % _userList.length;
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.transparent,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: 375.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Positioned.fill(
                child: Ink.image(
                  image: AssetImage(widget.imagePath),
                  fit: BoxFit.fitWidth,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
              ),
              Align(
                alignment: widget.textAlignment,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _reviewList[_currentIndex],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          color: Colors.white,
                          fontSize: 25.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        '- ${_userList[_currentIndex]} -',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          color: Colors.white,
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8.0),
                      Text(
                        _userOccupationList[_currentIndex],
                        textAlign: TextAlign.center,
                        style: GoogleFonts.kanit(
                          color: Colors.white,
                          fontSize: 18.0,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ContactForm extends StatefulWidget {
  const ContactForm({Key? key});

  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  final ServicioAuth servicioAuth = ServicioAuth();

  bool _nameClicked = false;
  bool _emailClicked = false;
  bool _messageClicked = false;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600.0,
      height: 450.0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Formulario de Contacto',
              style: GoogleFonts.kanit(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            CustomTextField(controller: _nameController, hintText: 'Nombre'),
            const SizedBox(height: 16.0),
            CustomTextField(
                controller: _emailController, hintText: 'Correo Electrónico'),
            const SizedBox(height: 16.0),
            CustomTextField(
              controller: _messageController,
              hintText: 'Mensaje',
              maxLines: 3,
            ),
            const SizedBox(height: 16.0),
            Center(
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 53, 47, 47),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () async {
                      String nombre = _nameController.text;
                      String email = _emailController.text;
                      String mensaje = _messageController.text;

                      if (nombre.isNotEmpty &&
                          email.isNotEmpty &&
                          mensaje.isNotEmpty) {
                        await servicioAuth.guardarFormulario(
                            nombre, email, mensaje);

                        // Limpiar los campos después de enviar el formulario
                        _nameController.clear();
                        _emailController.clear();
                        _messageController.clear();
                      } else {
                        // Manejar el caso en el que algún campo esté vacío
                      }

                      // Mostrar el SnackBar si el formulario se envió correctamente
                      if (servicioAuth.formularioEnviadoCorrectamente) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Formulario enviado correctamente'),
                          ),
                        );
                        servicioAuth.formularioEnviadoCorrectamente =
                            false; // Reiniciar el estado
                      }
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Center(
                        child: Text(
                          'ENVIAR',
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
            ),
          ],
        ),
      ),
    );
  }
}
