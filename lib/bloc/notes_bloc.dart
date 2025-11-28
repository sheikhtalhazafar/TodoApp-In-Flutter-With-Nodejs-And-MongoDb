import 'package:bloc/bloc.dart';
import 'package:todo_nodejs/bloc/notes_event.dart';
import 'package:todo_nodejs/bloc/notes_state.dart';
import 'package:todo_nodejs/model/notemodel.dart';
import 'package:todo_nodejs/services/api_services.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {

  final auth = Apiservices();
  NotesBloc() : super(const NotesState()) {
    on<PostNOtes>(postanote);
    on<FetchallNOtes>(fetchNOtes);
    on<DeleteNOtes>(deletSpeceficNOtes);
    on<UpdateNOtes>(updatenote);
  }

  void postanote(PostNOtes event, Emitter<NotesState> emit) async {
    emit(state.copyWith(message: 'loading'));

    final note = NoteModel(notes: event.notes);
    final String response = await auth.postNotes(note);

    emit(state.copyWith(postnote: event.notes, message: response));
  }

  void fetchNOtes(FetchallNOtes event, Emitter<NotesState> emit) async {
    emit(state.copyWith(message: 'loading'));

    final List<NoteModel> response = await auth.fetchallNOtes();
    emit(state.copyWith(comingnotes: response, message: 'success'));
  }

  void deletSpeceficNOtes(DeleteNOtes event, Emitter<NotesState> emit) async {
    try {
      emit(state.copyWith(message: 'loading'));
      final note = NoteModel(id: event.id);
      final String response = await auth.deleteNOte(note);
      if (response == 'deleted') {
        // remove note from local list
        final updatedNotes = List<NoteModel>.from(state.allNotes)
          ..removeWhere((note) => note.id == event.id);

        emit(state.copyWith(comingnotes: updatedNotes, message: 'deleted'));
      } else {
        emit(state.copyWith(message: 'Failed'));
      }
    } catch (e) {
      emit(state.copyWith(message: 'Failed'));
    }
  }

  void updatenote(UpdateNOtes event, Emitter<NotesState> emit) async {
    emit(state.copyWith(message: 'loading'));
    final note = NoteModel(id: event.id, notes: event.notes);
    final String response = await auth.updateNotes(note);
    emit(state.copyWith(postnote: event.notes, message: response));
  }
}
