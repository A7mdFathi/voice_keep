import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_procrew/models/note.dart';
import 'package:injectable/injectable.dart';

part 'note_list_event.dart';

part 'note_list_state.dart';

@injectable
class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  NoteListBloc() : super(NoteListInitial());
  final notesRef = FirebaseFirestore.instance
      .collection('notes')
      .withConverter<Note>(
    fromFirestore: (snapshots, _) => Note.fromJson(snapshots.data()!),
    toFirestore: (note, _) => note.toJson(),
  );

  StreamSubscription notesStream;

  @override
  Stream<NoteListState> mapEventToState(NoteListEvent event,) async* {
    if (event is NotesListFetched) {
      yield* _mapList(event);
    }
  }

  Stream<NoteListState> _mapList(NotesListFetched event) async* {
    yield NoteListLoading();
    try {
      notesStream?.cancel();
      notesStream = notesRef.snapshots().listen((event) {
        event.docs.map((e) {});
      });
    }
  }
}
