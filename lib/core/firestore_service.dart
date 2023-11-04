import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  final _firestoreReference = FirebaseFirestore.instance;

  gravar() {
    _firestoreReference.collection('pessoas').add({
      'nome': 'Paulo',
      'idade': 88,
      'estado_civil': 'casadop',
    });
  }

  CollectionReference<Map<String, dynamic>> listar() {
    return _firestoreReference.collection('pessoas');
  }
}
