import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_procrew/models/note.dart';
import 'package:injectable/injectable.dart';

@injectable
class NoteRepository {
  final ref = FirebaseFirestore.instance.collection('users');

  Stream<List<QueryDocumentSnapshot<Note>>> getNotes(String id) {
    final snaps = ref
        .doc(id)
        .collection('notes')
        .withConverter<Note>(
          fromFirestore: (snapshot, _) => Note.fromJson(snapshot.data()),
          toFirestore: (note, _) => note.toJson(),
        )
        .snapshots()
        .map((snapshot) => snapshot.docs);

    return snaps;
  }

  deleteNote(String userId, String noteId) async {
    return ref.doc(userId).collection('notes').doc(noteId).delete();
  }
}
