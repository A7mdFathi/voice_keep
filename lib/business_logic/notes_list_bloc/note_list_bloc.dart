import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:voice_keep/models/note.dart';
import 'package:voice_keep/repository/notes_repository.dart';

part 'note_list_event.dart';

part 'note_list_state.dart';

@injectable
class NoteListBloc extends Bloc<NoteListEvent, NoteListState> {
  NoteListBloc({this.noteRepository}) : super(NoteListInitial());

  StreamSubscription notesStream;
  final NoteRepository noteRepository;
  @override
  Stream<NoteListState> mapEventToState(
    NoteListEvent event,
  ) async* {
    if (event is NotesListFetched) {
      yield* _mapList(event);
    } else if (event is NotesListUpdated) {
      yield* _updateList(event);
    } else if (event is NoteDeleteFetched) {
      yield* _deleteNote(event);
    }
  }

  Stream<NoteListState> _mapList(NotesListFetched event) async* {
    yield NoteListLoading();
    notesStream?.cancel();
    notesStream = noteRepository.getNotes(event.userId).listen(
      (notes) {
        add(NotesListUpdated(notes.toList()));
      },
      onError: (e) => print('FIRESTORE ERROR ${e.toString()}'),
      onDone: () => print('Firestore Done'),
    );
  }

  @override
  Future<void> close() {
    notesStream.cancel();
    return super.close();
  }

  Stream<NoteListState> _updateList(NotesListUpdated event) async* {
    yield NoteListLoaded(event.notes);
  }

  Stream<NoteListState> _deleteNote(NoteDeleteFetched event) async* {
    try {
      noteRepository.deleteNote(event.userId, event.noteId);
      yield NoteDeletedSuccess();
    } catch (e) {
      yield NoteDeletedFailure();
    }
  }
}
