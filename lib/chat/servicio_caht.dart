import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:diamond_motor_sport/models/mensaje.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class ServicioChat{
   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
   final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getUsuaris(){
    return _firestore.collection("Usuarios").snapshots().map((event) {

      return event.docs.map((document) {

        final usuari = document.data();
        return usuari;

      }).toList();
    });
  }

  Future<void> EnviarMensaje(String idReceptor, mensaje) async {
    final String idUsuarioActual = _auth.currentUser!.uid;
    final String emailusuarioActual = _auth.currentUser!.email!;
    final Timestamp timestamp = Timestamp.now();

    Mensaje nuevoMensaje = Mensaje(
      idAutor: idUsuarioActual, 
      emailAutor: emailusuarioActual, 
      idReceptor: idReceptor, 
      mensaje: mensaje, 
      timestamp: timestamp);

      //Construimos el id de la sala de chat de este mensaje
      List<String> idusuarios = [
        idUsuarioActual,
        idReceptor,
      ];
      idusuarios.sort();
      String idSalaChat = idusuarios.join("_");
      await _firestore.collection("SalasChat").doc(idSalaChat).collection("Mensajes").add(nuevoMensaje.retornarMapaMensaje());
  }

  Stream<QuerySnapshot> getMensaje(String idUsuarioActual, idReceptor){

    //Queremos encontrar la sala de chat formada pro los dos usuarios.
    //  (idusuariActual i idReceptor)
    //Creamos el id de la sala de chat como cuando guardamos mensajes.
    List<String> idusuarios = [idUsuarioActual, idReceptor];
    idusuarios.sort();
    String idSalaChat = idusuarios.join("_");
    return _firestore.collection("SalasChat").doc(idSalaChat).collection("Mensajes").orderBy("timestamp", descending: false).snapshots();
  }

}