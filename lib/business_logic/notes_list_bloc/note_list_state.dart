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
