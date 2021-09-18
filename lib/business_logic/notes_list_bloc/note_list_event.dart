part of 'note_list_bloc.dart';

abstract class NoteListEvent extends Equatable {
  const NoteListEvent();
}

class NotesListFetched extends NoteListEvent {
  final String userId;

  NotesListFetched(this.userId);

  @override
  List<Object> get props => [userId];
}

class NotesListUpdated extends NoteListEvent {
  final List<QueryDocumentSnapshot<Note>> notes;

  @override
  // TODO: implement props
  List<Object> get props => [notes];

  NotesListUpdated(this.notes);
}