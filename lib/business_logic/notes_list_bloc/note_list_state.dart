part of 'note_list_bloc.dart';

abstract class NoteListState extends Equatable {
  const NoteListState();
}

class NoteListInitial extends NoteListState {
  @override
  List<Object> get props => [];
}

class NoteListLoading extends NoteListState {
  @override
  List<Object> get props => [];
}

class NoteListLoaded extends NoteListState {
  final List<QueryDocumentSnapshot<Note>> noteList;

  @override
  // TODO: implement props
  List<Object> get props => [noteList];

  NoteListLoaded(this.noteList);
}

class NoteDeletedSuccess extends NoteListState {
  @override
  // TODO: implement props
  List<Object> get props => [];

  NoteDeletedSuccess();
}

class NoteDeletedFailure extends NoteListState {
  @override
  // TODO: implement props
  List<Object> get props => [];

  NoteDeletedFailure();
}