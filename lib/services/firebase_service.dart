import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  Stream<QuerySnapshot> eventos() {
    return FirebaseFirestore.instance.collection('eventos').snapshots();
  }

  Future<QuerySnapshot> tipos() async {
    return FirebaseFirestore.instance.collection('tipos').get();
  }

  Future<void> eventoAgregar(String nombre, String lugar, String descripcion, String tipo, 
  DateTime fechaEvento,String horaEvento, estado,int likes,String rutaFoto) async {
    return FirebaseFirestore.instance.collection('eventos').doc().set({
      'nombre': nombre,
      'lugar':lugar,
      'descripcion':descripcion,
      'tipo':tipo,
      'fechaEvento': fechaEvento,
      'horaEvento':horaEvento,
      'estado':estado,
      'likes':likes,
      'rutaFoto':rutaFoto
    });
  }

  Future<void> eventoBorrar(String docId) {
    return FirebaseFirestore.instance.collection('eventos').doc(docId).delete();
  }
}
