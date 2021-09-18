import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_procrew/models/note.dart';
import 'package:injectable/injectable.dart';

@injectable
class NoteRepository {
  Stream<List<QueryDocumentSnapshot<Note>>> getNoteRefrence(String id) {
    final ref = FirebaseFirestore.instance
        .collection('users')
        .doc('id')
        .collection('notes')
        .withConverter<Note>(
          fromFirestore: (snapshot, _) => Note.fromJson(snapshot.data()),
          toFirestore: (note, _) => note.toJson(),
        )
        .snapshots()
        .map((snapshot) => snapshot.docs);

    return ref;
  }
}
