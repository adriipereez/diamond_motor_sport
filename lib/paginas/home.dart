import 'dart:async';
import 'package:diamond_motor_sport/componentes/customTextField.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:diamond_motor_sport/paginas/gridanuncios.dart';
import 'package:diamond_motor_sport/paginas/sobrenosotros.dart';
import 'package:diamond_motor_sport/componentes/footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_player/video_player.dart';


class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(
        showBottomLine: true,
      ),
      drawer: CustomDrawer(),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              width: screenWidth,
              height: screenHeight,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  const VideoPlayerWidget(videoPath: 'assets/mainvideo.mp4'),
                  Positioned(
                    top: screenHeight * 0.45,
                    left: screenWidth * 0.05,
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
                                builder: (context) => const GridAnuncios(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                          ),
                          child: const Text(
                            'Explorar',
                            style: TextStyle(fontSize: 20, color: Colors.white),
                          ),
                        ),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const SobreNosotros(),
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
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: [
                  SizedBox(height: 75.0),
                  SizedBox(
                    width: double.infinity,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: HoverImageWidget(
                            'assets/image1.jpg',
                            Text(
                            'Coches Gasolina',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: HoverImageWidget(
                            'assets/image2.jpg',
                            Text(
                              'Coches Diesel',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: HoverImageWidget(
                            'assets/image3.jpg',
                            Text(
                              'Coches Hibridos',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 16.0),
                        Expanded(
                          child: HoverImageWidget(
                            'assets/image4.jpg',
                            Text(
                              'Coches electricos',
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  ImageWithTextSlider(
                    imagePath: 'assets/main1.jpg',
                    textAlignment: Alignment.center,
                  ),
                  SizedBox(height: 75.0),
                  ContactForm(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class VideoPlayerWidget extends StatefulWidget {
  final String videoPath;

  const VideoPlayerWidget({required this.videoPath, Key? key})
      : super(key: key);

  @override
  _VideoPlayerWidgetState createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset(widget.videoPath)
      ..initialize().then((_) {
        _controller.play();
        setState(() {});
        _controller.setLooping(true);
        _controller.setVolume(0.0);
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return _controller.value.isInitialized
        ? Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller.value.size.width,
                  height: _controller.value.size.height,
                  child: VideoPlayer(_controller),
                ),
              ),
            ),
          )
        : Container();
  }
}

class HoverImageWidget extends StatelessWidget {
  final String imagePath;
  final Widget child;

  const HoverImageWidget(this.imagePath, this.child, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: double.infinity,
        height: 300.0,
        child: ClipRRect(
          child: Stack(
            fit: StackFit.expand,
            children: [
              Ink.image(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    print('Tocaste la imagen');
                  },
                ),
              ),
              Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: child,
                ),
              ),
            ],
          ),
        ),
      ),
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
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(
                            _reviewList[_currentIndex],
                            style: GoogleFonts.kanit(
                              color: Colors.white,
                              fontSize: 30.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            _userList[_currentIndex],
                            style: GoogleFonts.kanit(
                              color: Colors.white,
                              fontSize: 25.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          Text(
                            _userOccupationList[_currentIndex],
                            style: GoogleFonts.kanit(
                              color: Colors.white,
                              fontSize: 18.0,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                      const SizedBox(height: 8.0),
                      TextSlider(
                        currentIndex: _currentIndex,
                        textList: _userList,
                        onChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
                      ),
                      const SizedBox(height: 8.0),
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

class TextSlider extends StatelessWidget {
  final int currentIndex;
  final List<String> textList;
  final ValueChanged<int> onChanged;

  const TextSlider({
    required this.currentIndex,
    required this.textList,
    required this.onChanged,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          width: 40.0,
          child: IconButton(
            icon: const Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed:
                currentIndex > 0 ? () => onChanged(currentIndex - 1) : null,
          ),
        ),
        SizedBox(
          width: 40.0,
          child: IconButton(
            icon: const Icon(Icons.arrow_forward),
            color: Colors.white,
            onPressed: currentIndex < textList.length - 1
                ? () => onChanged(currentIndex + 1)
                : null,
          ),
        ),
      ],
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
            CustomTextField(controller: _emailController, hintText: 'Correo Electrónico'),
             const SizedBox(height: 16.0),
            CustomTextField(controller: _messageController, hintText: 'Mensaje', maxLines: 3,),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                print('Enviando formulario...');
                print('Nombre: ${_nameController.text}');
                print('Correo Electrónico: ${_emailController.text}');
                print('Mensaje: ${_messageController.text}');
              },
              child: const Text('Enviar'),
            ),
          ],
        ),
      ),
    );
  }
}
