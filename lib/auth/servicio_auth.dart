import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicioAuth{

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  //hacer login
  Future<UserCredential> loginConEmailPassword(String email, password) async {
    try {
      UserCredential credencialusuario = await _auth.signInWithEmailAndPassword(
        email: email, 
        password: password
      );
      return credencialusuario;
    } on   FirebaseAuthException catch (error) {
      throw Exception(error.code);
    }
    
  } 
  //hacer registro
   Future<UserCredential> RegistroConEmailPassword(String email, password, nombre, apellido, telefono) async {
    try {
      UserCredential credencialusuario = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password,
      );

      if (credencialusuario.user != null) {
      String uid = credencialusuario.user!.uid;
      _firestore.collection("Usuarios").doc(uid).set({
        "uid": credencialusuario.user!.uid,
        "email": email,
        "nombre": nombre,
        "apellido": apellido,
        "telefono": telefono,
      });
    } else {
      throw Exception("El usuario es nulo");
    }

  
      return credencialusuario;
    } on   FirebaseAuthException catch (error) {
      throw Exception(error.code);
    }
    
  } 

  //hacer logout
  Future<void> cerrarsesion() async {
    return await _auth.signOut();
  }
}