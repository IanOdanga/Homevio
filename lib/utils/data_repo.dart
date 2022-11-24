import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homevio/models/request_model.dart';

class DataRepository {
  DataRepository({required this.firestore});

  final FirebaseFirestore firestore;

  CollectionReference get collection =>
      firestore.collection('notes');

  //Retour de models a la place de snapshots
  Stream<QuerySnapshot> getStream() {
    return collection.snapshots();
  }

  Stream<QuerySnapshot> getStreamDetail(String id) {
    return collection.doc(id).collection('tasks').snapshots();
  }

  Stream<List<RequestModel>> noteStream() {
    try {
      return collection.snapshots().map((notes) {
        final List<RequestModel> notesFromFirestore = <RequestModel>[];
        for (var doc in notes.docs) {
          notesFromFirestore.add(RequestModel.fromMap(doc));
        }
        return notesFromFirestore;
      });
    } catch (e) {
      rethrow;
    }
  }
}