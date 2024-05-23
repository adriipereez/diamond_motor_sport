import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class ServicioAuth {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  bool formularioEnviadoCorrectamente = false;
  bool anuncioEnviadoCorrectamente = false;

  Future<UserCredential> loginConEmailPassword(
      String email, String password) async {
    try {
      UserCredential credencialusuario = await _auth.signInWithEmailAndPassword(
          email: email, password: password);

      if (credencialusuario.user != null) {
        String uid = credencialusuario.user!.uid;

        DocumentSnapshot userSnapshot =
            await _firestore.collection("Usuarios").doc(uid).get();

        if (userSnapshot.exists) {
          Map<String, dynamic>? userData =
              userSnapshot.data() as Map<String, dynamic>?;
          if (userData != null && !userData.containsKey("admin")) {
            await _firestore.collection("Usuarios").doc(uid).update({
              "admin": false,
            });
          }
        } else {
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
          "admin": false,
        });
      }
      return credencialusuario;
    } on FirebaseAuthException catch (error) {
      throw Exception(error.code);
    }
  }

  Future<void> cerrarsesion() async {
    return await _auth.signOut();
  }

  User? getUsuarioActual() {
    return _auth.currentUser;
  }

  Future<String> obtenerDatosUsuario(String uid) async {
    try {
      DocumentSnapshot snapshot =
          await _firestore.collection('Usuarios').doc(uid).get();

      if (snapshot.exists) {
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
      formularioEnviadoCorrectamente = true;
    } catch (e) {
      throw Exception('Error al guardar el formulario: $e');
    }
  }

  Future<String> guardarAnuncio(
    String marca,
    String modelo,
    int km,
    int any,
    String descripcion,
    String tipoCoche,
    String tipoCombustible,
    double precio, 
    String uid,
  ) async {
    try {
      DocumentReference docRed = await _firestore.collection('Anuncios').add({
        'uid': uid, // Guardar el UID del usuario junto con el anuncio
        'marca': marca,
        'modelo': modelo,
        'km': km,
        'any': any,
        'descripcion': descripcion,
        'tipoCoche': tipoCoche,
        'tipoCombustible': tipoCombustible,
        'precio': precio, 
        'uid': uid,
      });
      anuncioEnviadoCorrectamente = true;
      return docRed.id;
    } catch (e) {
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
      return false;
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

        await FirebaseFirestore.instance
            .collection('Usuarios')
            .doc(currentUser.uid)
            .delete();

        formularioEnviadoCorrectamente = true;
      } else {
        throw Exception('No se pudo obtener el usuario actual');
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'requires-recent-login') {
        throw Exception(
            'Debes volver a iniciar sesión recientemente para eliminar la cuenta');
      } else {
        throw Exception('Error al eliminar la cuenta: $e');
      }
    } catch (e) {
      throw Exception('Error al eliminar la cuenta: $e');
    }
  }

  Future<List<Map<String, dynamic>>> obtenerAnunciosConDocumentos() async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('Anuncios').get();
      List<Map<String, dynamic>> anuncios = [];

      for (var doc in querySnapshot.docs) {
        Map<String, dynamic> anuncioData = doc.data() as Map<String, dynamic>;
        String nombreDocumento = doc.id;
        anuncioData['nombreDocumento'] = nombreDocumento;

        // Obtener URL de la imagen
        String imageUrl = await _obtenerUrlImagen(nombreDocumento);
        anuncioData['imageUrl'] = imageUrl;

        anuncios.add(anuncioData);
      }
      return anuncios;
    } catch (e) {
      throw Exception('Error al obtener los anuncios: $e');
    }
  }

  Future<String> _obtenerUrlImagen(String documentName) async {
    try {
      Reference ref = _storage.ref().child('$documentName/imagen/$documentName');
      String url = await ref.getDownloadURL();
      return url;
    } catch (e) {
      throw Exception('Error al obtener la URL de la imagen: $e');
    }
  }

   bool get isLoggedIn {
    return _auth.currentUser != null;
  }
}
