import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:diamond_motor_sport/componentes/footer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatelessWidget {
  const Home({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const CustomAppBar(showBottomLine: true,),
      drawer: CustomDrawer(),
      backgroundColor: Colors.black,
      body: 
      ListView(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height,
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(
                  'assets/mainphoto.jpg',
                  fit: BoxFit.cover,
                ),
                Positioned(
                  top: 300.0,
                  left: 50.0,
                  child: Text(
                    'Compra y vende los mejores coches de lujo',
                    style: GoogleFonts.novaMono(
                      color: Colors.white,
                      fontSize: 35.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                const SizedBox(height: 16.0),
                const SizedBox(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: HoverImageWidget('assets/image1.jpg',
                            'Coches deportivos', Alignment.bottomCenter),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: HoverImageWidget('assets/image2.jpg',
                            'Coches todoterreno', Alignment.bottomCenter),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: HoverImageWidget('assets/image3.jpg',
                            'Coches descapotables', Alignment.bottomCenter),
                      ),
                      SizedBox(width: 16.0),
                      Expanded(
                        child: HoverImageWidget('assets/image4.jpg',
                            'Coches Utilitarios', Alignment.bottomCenter),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 100.0),
                LayoutBuilder(
                  builder: (context, constraints) {
                    double imageSize =
                        constraints.maxWidth > 600 ? 400.0 : 200.0;
                    return SizedBox(
                      width: double.infinity,
                      height: imageSize,
                      child: const HoverImageWithTextSlider(
                          '/main1.jpg', Alignment.bottomCenter),
                    );
                  },
                ),
                const SizedBox(height: 100.0),
                Container(
                  margin: const EdgeInsets.only(left: 16.0),
                  child: const ContactForm(),
                ),
                const Divider(),
                const Footer(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class HoverImageWidget extends StatelessWidget {
  final String imagePath;
  final String text;
  final Alignment textAlignment;

  const HoverImageWidget(this.imagePath, this.text, this.textAlignment,
      {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: SizedBox(
        width: double.infinity,
        height: 300.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Ink.image(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    print('Tocaste la imagen: $text');
                  },
                ),
              ),
              Align(
                alignment: textAlignment,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24.0,
                    ),
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

class HoverImageWithTextSlider extends StatefulWidget {
  final String imagePath;
  final Alignment textAlignment;

  const HoverImageWithTextSlider(this.imagePath, this.textAlignment, {Key? key})
      : super(key: key);

  @override
  _HoverImageWithTextSliderState createState() =>
      _HoverImageWithTextSliderState();
}

class _HoverImageWithTextSliderState extends State<HoverImageWithTextSlider> {
  int _currentIndex = 0;
  List<String> _textList = [
    'Muy buena pagina : Leo Messi',
    'Bonicos coxes : Sergio Ramos',
    'Carro muito bom : Neymar Jr',
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('Tocaste la imagen: ${_textList[_currentIndex]}');
      },
      child: SizedBox(
        width: 500.0,
        height: 325.0,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Ink.image(
                image: AssetImage(widget.imagePath),
                fit: BoxFit.cover,
                child: InkWell(
                  borderRadius: BorderRadius.circular(8.0),
                  onTap: () {
                    print('Tocaste la imagen: ${_textList[_currentIndex]}');
                  },
                ),
              ),
              Align(
                alignment: widget.textAlignment,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _textList[_currentIndex],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      TextSlider(
                        currentIndex: _currentIndex,
                        textList: _textList,
                        onChanged: (index) {
                          setState(() {
                            _currentIndex = index;
                          });
                        },
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
        Text('${currentIndex + 1}/${textList.length}'),
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
            const Text(
              'Formulario de Contacto',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _nameController,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Correo Electrónico',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16.0),
            TextFormField(
              controller: _messageController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Mensaje',
                border: OutlineInputBorder(),
              ),
            ),
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