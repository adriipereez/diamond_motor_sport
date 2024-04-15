import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicioAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //hacer login
  Future<UserCredential> loginConEmailPassword(String email, password) async {
    try {
      UserCredential credencialusuario = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      if (credencialusuario.user != null) {
        String uid = credencialusuario.user!.uid;
      }
      return credencialusuario;
    } on FirebaseAuthException catch (error) {
      throw Exception(error.code);
    }
  }

  //hacer registro
  Future<UserCredential> registroConEmailPassword(
      String email, password, nombre, apellido, telefono) async {
    try {
      UserCredential credencialusuario =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credencialusuario.user != null) {
        String uid = credencialusuario.user!.uid;
        await _firestore.collection("Usuarios").doc(uid).set({
          "uid": credencialusuario.user!.uid,
          "email": email,
          "nombre": nombre,
          "apellido": apellido,
          "telefono": telefono,
        });
      }

      return credencialusuario;
    } on FirebaseAuthException catch (error) {
      throw Exception(error.code);
    }
  }

  //hacer logout
  Future<void> cerrarsesion() async {
    return await _auth.signOut();
  }

User? getUsuarioActual(){
    return _auth.currentUser;
  }

Future<String> obtenerDatosUsuario(String uid) async { print('hola');
  try {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    DocumentSnapshot snapshot = await firestore.collection('Usuarios').doc(uid).get();

    if (snapshot.exists) {
      // Si el documento existe, puedes acceder a todos los campos
      Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
      /*print('Datos del usuario:');
      data.forEach((key, value) {
        print('$key: $value');
      });*/
      return data['nombre'];
    } else {
      return('El documento no existe');
    }
  } catch (error) {
    return('Error al obtener los datos del usuario: $error');
  }

}
}
