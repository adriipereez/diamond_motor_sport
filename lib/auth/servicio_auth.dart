import 'package:firebase_auth/firebase_auth.dart';

class ServicioAuth{

  final FirebaseAuth _auth = FirebaseAuth.instance;

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
   Future<UserCredential> RegistroConEmailPassword(String email, password) async {
    try {
      UserCredential credencialusuario = await _auth.createUserWithEmailAndPassword(
        email: email, 
        password: password
      );
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