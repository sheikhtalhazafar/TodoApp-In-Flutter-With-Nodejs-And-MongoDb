import 'package:equatable/equatable.dart';
import 'package:todo_nodejs/model/notemodel.dart';

class NotesState extends Equatable {
  final String postnote;
  final String message;
  final List<NoteModel> allNotes;
  const NotesState({
    this.postnote = '',
    this.message = '',
    this.allNotes = const [],
  });

  NotesState copyWith({
    String? postnote,
    String? message,
    List<NoteModel>? comingnotes,
  }) {
    return NotesState(
      postnote: postnote ?? this.postnote,
      message: message ?? this.message,
      allNotes: comingnotes ?? allNotes,
    );
  }

  @override
  List<Object> get props => [postnote, allNotes, message];
}
