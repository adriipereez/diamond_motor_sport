import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_motor_sport/chat/servicio_caht.dart';
import 'package:diamond_motor_sport/componentes/bombollaMensaje.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:flutter/material.dart';
import 'package:diamond_motor_sport/auth/servicio_auth.dart';

class PaginaChat extends StatefulWidget {
  final String emailConQuienhablamos;
  final String idReceptor;

  const PaginaChat({
    Key? key,
    required this.emailConQuienhablamos,
    required this.idReceptor,
  }) : super(key: key);

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {
  final TextEditingController controllerMensaje = TextEditingController();

  final ServicioAuth servicioAuth = ServicioAuth();

  final ServicioChat servicioChat = ServicioChat();

  final ScrollController controllerScroll = ScrollController();

  final FocusNode focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      Future.delayed(
        const Duration(milliseconds: 500),
        () => hacerScroll(),
      );
    });
    Future.delayed(
      const Duration(milliseconds: 500),
      () => hacerScroll(),
    );
  }

  @override
  void dispose() {
    focusNode.dispose();
    controllerMensaje.dispose();
    super.dispose();
  }

  void hacerScroll() {
    controllerScroll.animateTo(controllerScroll.position.maxScrollExtent,
        duration: const Duration(seconds: 1),
        curve: Curves.fastLinearToSlowEaseIn);
  }

  void EnviarMensaje() async {
    if (controllerMensaje.text.isNotEmpty) {
      await servicioChat.EnviarMensaje(
          widget.idReceptor, controllerMensaje.text);
      controllerMensaje.clear();
    }
    hacerScroll();
  }

  void redirigirAChatConUsuario() {
    // Aquí debes agregar la lógica para redirigir al usuario al chat con la persona que publicó el anuncio.
    // Puedes usar Navigator para realizar la navegación.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 143, 134, 134),
      appBar: const CustomAppBar(),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(child: _contruirlistaMensajes()),
            _contruirZonaInputUsuario(),
            ElevatedButton(
              onPressed: redirigirAChatConUsuario,
              child: Text('Chat con el usuario que publicó el anuncio'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _contruirlistaMensajes() {
    String idUsuarioActual = servicioAuth.getUsuarioActual()!.uid;

    return StreamBuilder(
        stream: servicioChat.getMensaje(idUsuarioActual, widget.idReceptor),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Text("Error al cargar el mensaje");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Cargando...");
          }
          return ListView(
            controller: controllerScroll,
            children: snapshot.data!.docs
                .map((document) => _contruirItemMensaje(document))
                .toList(),
          );
        });
  }

  Widget _contruirItemMensaje(DocumentSnapshot documentSnapshot) {
    Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;

    bool esUsuarioActual =
        data["idAutor"] == servicioAuth.getUsuarioActual()!.uid;

    var aliniament =
        esUsuarioActual ? Alignment.centerRight : Alignment.centerLeft;
    var colorBombolla = esUsuarioActual ? Colors.green[200] : Colors.amber[300];

    return Container(
      alignment: aliniament,
      child: BombollaMensaje(
        colorBombolla: colorBombolla ?? Colors.black,
        mensaje: data["mensaje"],
        timestamp: data["timestamp"],
      ),
    );
  }

  Widget _contruirZonaInputUsuario() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controllerMensaje,
              decoration: const InputDecoration(
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Color.fromARGB(255, 255, 17, 0)),
                      borderRadius: BorderRadius.all(Radius.circular(10.0))),
                  fillColor: Color.fromARGB(255, 0, 0, 0),
                  filled: true,
                  hintText: "Escribe el mensaje...",
                  hintStyle:
                      TextStyle(color: Color.fromARGB(255, 143, 139, 139)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)))),
              style: const TextStyle(color: Color.fromARGB(255, 255, 255, 255)),
              cursorColor: const Color.fromARGB(255, 255, 0, 0),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          IconButton(
            style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black)),
            icon: const Icon(Icons.send),
            color: Color.fromARGB(255, 255, 0, 0),
            onPressed: EnviarMensaje,
          ),
        ],
      ),
    );
  }
}
