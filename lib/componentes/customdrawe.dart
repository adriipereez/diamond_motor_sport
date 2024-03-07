import 'package:flutter/material.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Color.fromARGB(255, 0, 0, 0), // Cambia el color de fondo del Drawer aquí
        child: Column(
          children: [
            DrawerHeader(
              child: Image.asset(
                'assets/diamante.png', // Ruta de la imagen personalizada
                width: 150, // Ajusta el ancho de la imagen según tus necesidades
                height: 150, // Ajusta la altura de la imagen según tus necesidades
              ),
            ),
            SizedBox(height: 20), // Espacio entre la imagen y los ListTile
            Container(
              alignment: Alignment.center, // Centra horizontalmente los elementos
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.home, color: Colors.white), // Cambia el color del ícono
                    title: Text("Primera Página", style: TextStyle(color: Colors.white)), // Cambia el color del texto
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/primera_pagina");
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.post_add, color: Colors.white), // Cambia el color del ícono
                    title: Text("Anuncio", style: TextStyle(color: Colors.white)), // Cambia el color del texto
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/pizza");
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.add_shopping_cart, color: Colors.white), // Cambia el color del ícono
                    title: Text("Lista Sillas", style: TextStyle(color: Colors.white)), // Cambia el color del texto
                    onTap: () {
                      Navigator.pushReplacementNamed(context, "/listasillas");
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
