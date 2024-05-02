import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ServicioAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  bool formularioEnviadoCorrectamente = false;
  bool anuncioEnviadoCorrectamente = false;

  Future<UserCredential> loginConEmailPassword(
      String email, String password) async {
    try {
      UserCredential credencialusuario = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (credencialusuario.user != null) {
        String uid = credencialusuario.user!.uid;

        // Verificar si el usuario ya existe en Firestore
        DocumentSnapshot userSnapshot =
            await _firestore.collection("Usuarios").doc(uid).get();

        if (userSnapshot.exists) {
          // El usuario ya existe en Firestore
          Map<String, dynamic>? userData =
              userSnapshot.data() as Map<String, dynamic>?;
          if (userData != null && !userData.containsKey("admin")) {
            // Si el usuario no tiene el campo "admin", establecerlo en false
            await _firestore.collection("Usuarios").doc(uid).update({
              "admin": false,
            });
          }
        } else {
          // Si el usuario no existe, crearlo con el campo "admin" en false
          await _firestore.collection("Usuarios").doc(uid).set({
            "uid": credencialusuario.user!.uid,
            "email": email,
            "nombre": "",
            "admin": false,
          });
        }
      } else {
        throw Exception("El usuario es nulo");
      }
      return credencialusuario;
    } on FirebaseAuthException catch (error) {
      throw Exception(error.code);
    }
  }

  Future<UserCredential> registroConEmailPassword(String email, String password,
      String nombre, String apellido, String telefono) async {
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
          "admin": false, // Establecer el valor de admin como false por defecto
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

  User? getUsuarioActual() {
    return _auth.currentUser;
  }

  Future<String> obtenerDatosUsuario(String uid) async {
    try {
      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentSnapshot snapshot =
          await firestore.collection('Usuarios').doc(uid).get();

      if (snapshot.exists) {
        // Si el documento existe, puedes acceder a todos los campos
        Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        return data['nombre'];
      } else {
        return ('El documento no existe');
      }
    } catch (error) {
      return ('Error al obtener los datos del usuario: $error');
    }
  }

  Future<void> guardarFormulario(
      String nombre, String email, String mensaje) async {
    try {
      await _firestore.collection('formulario').add({
        'nombre': nombre,
        'email': email,
        'mensaje': mensaje,
        'timestamp': FieldValue.serverTimestamp(),
      });
      formularioEnviadoCorrectamente =
          true; // Marcar como enviado correctamente
    } catch (e) {
      throw Exception('Error al guardar el formulario: $e');
    }
  }

  Future<void> guardarAnuncio(
      String marca, String modelo, int km, int any, String descripcion, String tipoCoche, String tipoCombustible) async {
    try {
      await _firestore.collection('Anuncios').add({
        'marca': marca,
        'modelo': modelo,
        'km': km,
        'any': any,
        'descripcion': descripcion,
        'tipoCoche':tipoCoche,
        'tipoCombustible':tipoCombustible,
      });
      // Establecer la variable anuncioEnviadoCorrectamente después de la operación add
      anuncioEnviadoCorrectamente = true;
    } catch (e) {
      // Manejar cualquier excepción lanzada durante la operación add
      throw Exception('Error al guardar el anuncio: $e');
    }
  }

  Future<bool> esUsuarioAdmin(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('Usuarios').doc(uid).get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        if (data != null && data.containsKey('admin')) {
          return data['admin'] ?? false;
        }
      }
      return false; // Si el campo 'admin' no existe, asumir que el usuario no es administrador
    } catch (error) {
      throw Exception(
          'Error al verificar si el usuario es administrador: $error');
    }
  }

  Future<void> deleteAccount() async {
  try {
    User? currentUser = FirebaseAuth.instance.currentUser;

    if (currentUser != null) {
      await currentUser.delete();

      await FirebaseFirestore.instance.collection('Usuarios').doc(currentUser.uid).delete();

      formularioEnviadoCorrectamente = true;
    } else {
      throw Exception('No se pudo obtener el usuario actual');
    }
  } on FirebaseAuthException catch (e) {
    if (e.code == 'requires-recent-login') {

      throw Exception('Debes volver a iniciar sesión recientemente para eliminar la cuenta');
    } else {
      throw Exception('Error al eliminar la cuenta: $e');
    }
  } catch (e) {
    throw Exception('Error al eliminar la cuenta: $e');
  }
}
