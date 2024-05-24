import 'dart:html';
import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_motor_sport/auth/servicio_auth.dart';
import 'package:diamond_motor_sport/chat/servicio_caht.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/customdrawer.dart';
import 'package:diamond_motor_sport/componentes/customappbar.dart';
import 'package:diamond_motor_sport/componentes/item_usuario.dart';
import 'package:diamond_motor_sport/paginas/Chat.dart';
import 'package:flutter/material.dart';

class Listachats extends StatelessWidget {
  Listachats({super.key});
  final ServicioAuth _servicioAuth = ServicioAuth();
  final ServicioChat _servicioChat = ServicioChat();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(
        showBottomLine: true,
      ),
      drawer: CustomDrawer(),
      backgroundColor: Colors.black,
      body: _construirListaDeUsuarios(),
    );
  }

  Widget _construirListaDeUsuarios() {
    return StreamBuilder(
        stream: _servicioChat.getUsuaris(),
        builder: (context, Snapshot) {
          //Mirar si hay error
          if (Snapshot.hasError) {
            return const Text("Error");
          }
          //Esperar a que carguen los datos
          if (Snapshot.connectionState == ConnectionState.waiting) {
            return const Text("Cargando datos...");
          }

          //Se retornan los datos
          return ListView(
            children: Snapshot.data!
                .map<Widget>((datosusuario) =>
                    _contruirItemUsuario(datosusuario, context))
                .toList(),
          );
        });
  }

  Widget _contruirItemUsuario(
      Map<String, dynamic> datosusuario, BuildContext context) {
    if (datosusuario["email"] == _servicioAuth.getUsuarioActual()!.email) {
      return Container();
    }

    return StreamBuilder<QuerySnapshot>(
      stream: _servicioChat.getMensaje(
        _servicioAuth.getUsuarioActual()!.uid,
        datosusuario["uid"],
      ),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.data!.docs.isEmpty) {
          // No hay mensajes, no se muestra el item de usuario
          return Container();
        }

        return Itemusuario(
          emailUsuario: datosusuario['email'],
          Ontap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => PaginaChat(
                  emailConQuienhablamos: datosusuario["email"],
                  idReceptor: datosusuario["uid"],
                ),
              ),
            );
          },
        );
      },
    );
  }

  void logout() {
    _servicioAuth.cerrarsesion();
  }
}
