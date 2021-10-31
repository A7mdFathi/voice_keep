import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:voice_keep/models/note.dart';

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

  deleteNote(String userId, String noteId, String noteUrl) async {
    await ref.doc(userId).collection('notes').doc(noteId).delete();
    await FirebaseStorage.instance.refFromURL(noteUrl).delete();
  }
}
