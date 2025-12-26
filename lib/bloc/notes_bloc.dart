import 'package:bloc/bloc.dart';
import 'package:todo_nodejs/bloc/notes_event.dart';
import 'package:todo_nodejs/bloc/notes_state.dart';
import 'package:todo_nodejs/model/notemodel.dart';
import 'package:todo_nodejs/services/api_services.dart';

class NotesBloc extends Bloc<NotesEvent, NotesState> {
  NotesBloc() : super(const NotesState()) {
    on<FetchallNOtes>(_fetchNotes);
    on<PostNOtes>(_addNote);
    on<DeleteNOtes>(_deleteNote);
    on<UpdateNOtes>(_updateNote);
  }

  // FETCH NOTES
  Future<void> _fetchNotes(
    FetchallNOtes event,
    Emitter<NotesState> emit,
  ) async {
    Apiservices api = Apiservices();
    emit(state.copyWith(status: NotesStatus.loading));

    final notes = await api.fetchallNOtes();

    emit(state.copyWith(status: NotesStatus.success, allNotes: notes));
  }

  // ADD NOTE
  Future<void> _addNote(PostNOtes event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NotesStatus.loading));
    Apiservices api = Apiservices();
    final response = await api.postNotes(NoteModel(notes: event.notes));

    emit(
      state.copyWith(
        status: response == 'success' ? NotesStatus.success : NotesStatus.error,
        message: response,
      ),
    );
  }

  // DELETE NOTE
  Future<void> _deleteNote(DeleteNOtes event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NotesStatus.loading));
    Apiservices api = Apiservices();
    final result = await api.deleteNOte(NoteModel(id: event.id));

    if (result == 'deleted') {
      final updated = List<NoteModel>.from(state.allNotes)
        ..removeWhere((e) => e.id == event.id);

      emit(state.copyWith(status: NotesStatus.deleted, allNotes: updated));
    } else {
      emit(state.copyWith(status: NotesStatus.error));
    }
  }

  // UPDATE NOTE
  Future<void> _updateNote(UpdateNOtes event, Emitter<NotesState> emit) async {
    emit(state.copyWith(status: NotesStatus.loading));
    Apiservices api = Apiservices();
    final response = await api.updateNotes(
      NoteModel(id: event.id, notes: event.notes),
    );

    emit(
      state.copyWith(
        status: response == 'success' ? NotesStatus.success : NotesStatus.error,
        message: response,
      ),
    );
  }
}
