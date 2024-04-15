import 'dart:html';
import 'dart:js_interop';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:diamond_motor_sport/chat/servicio_caht.dart';
import 'package:diamond_motor_sport/componentes/bombollaMensaje.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class PaginaChat extends StatefulWidget {
  final String emailConQuienhablamos;
  final String idReceptor;

  const PaginaChat({
    super.key,
    required this.emailConQuienhablamos,
    required this.idReceptor,
    });

  @override
  State<PaginaChat> createState() => _PaginaChatState();
}

class _PaginaChatState extends State<PaginaChat> {

  final TextEditingController controllerMensaje = TextEditingController();

  final ServicioAuth servicioAuth = ServicioAuth();

  final ServicioChat servicioChat = ServicioChat();

  final ScrollController controllerScroll = ScrollController();

  //variable para el teclado del mvil

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
    // Nos esperamos un momento y entonce movemos para abajo
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

  void hacerScroll(){
    controllerScroll.animateTo(
      controllerScroll.position.maxScrollExtent,
      duration: const Duration(seconds: 1), 
      curve: Curves.fastLinearToSlowEaseIn);
  }

  void EnviarMensaje() async {
    if(controllerMensaje.text.isNotEmpty){
      //Enviar el mensaje
      await servicioChat.EnviarMensaje(
        widget.idReceptor, 
        controllerMensaje.text
      );
      //Limpiar el campo
      controllerMensaje.clear();
    }
    hacerScroll();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.emailConQuienhablamos),
      ),
      body: Column(
        children: [
          //Zona mensajes

          Expanded(
            child: _contruirlistaMensajes()
          ),

          //Zona escribir mensaje
          _contruirZonaInputUsuario(),

        ],
      ),
    );
  }

  Widget _contruirlistaMensajes(){

    String idUsuarioActual = servicioAuth.getUsuarioActual()!.uid;

    return StreamBuilder(
      stream: servicioChat.getMensaje(idUsuarioActual, widget.idReceptor), 
      builder: (context, snapshot){

        // En caso de que haya algun error
        if (snapshot.hasError){
          return const Text("Error al cargar el mensaje");
        }
        // Estar cargando
        if (snapshot.connectionState == ConnectionState.waiting){
          return const Text("Cargando...");
        }
        // Retornar dades (ListView)
        return ListView(
          controller: controllerScroll,
          children: snapshot.data!.docs.map((document) => _contruirItemMensaje(document)).toList(),
        );
      }
      );
  }

  Widget _contruirItemMensaje(DocumentSnapshot documentSnapshot){

    Map<String, dynamic> data = documentSnapshot.data() as Map<String,dynamic>;

    //Saber si lo mostramos a la izquierda o a la derecha

    // Si es usuario actual
    bool esUsuarioActual = data["idAutor"] == servicioAuth.getUsuarioActual()!.uid;
    print("hola");
    print(data["mensaje"]);

    var aliniament = esUsuarioActual ? Alignment.centerRight : Alignment.centerLeft;
    var colorBombolla = esUsuarioActual ? Colors.green[200] : Colors.amber[300];

    return Container(
      alignment: aliniament,
      child: BombollaMensaje(
        colorBombolla : colorBombolla??Colors.black,
        mensaje: data["mensaje"]
      )
    );
  }

  Widget _contruirZonaInputUsuario(){
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controllerMensaje,
              decoration: InputDecoration(
                fillColor: Colors.amber[100],
                filled: true,
                hintText: "Escribe el mensaje...",
              ),
              
            ),
          ),
          const SizedBox(width: 10,),
          IconButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.black)
            ),
          icon: Icon(Icons.send),
          color: Colors.pink,
          onPressed: EnviarMensaje, 
          ),
        ],
      ),
    );
  }
}
