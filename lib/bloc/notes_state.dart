import 'package:equatable/equatable.dart';
import 'package:todo_nodejs/model/notemodel.dart';

class NotesState {
  final NotesStatus status;
  final List<NoteModel> allNotes;
  final String? message;

  const NotesState({
    this.status = NotesStatus.initial,
    this.allNotes = const [],
    this.message,
  });

  NotesState copyWith({
    NotesStatus? status,
    List<NoteModel>? allNotes,
    String? message,
  }) {
    return NotesState(
      status: status ?? this.status,
      allNotes: allNotes ?? this.allNotes,
      message: message,
    );
  }
}