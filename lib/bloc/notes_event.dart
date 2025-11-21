import 'package:equatable/equatable.dart';

class NotesEvent extends Equatable {
  const NotesEvent();

  @override
  List<Object> get props => [];
}

class PostNOtes extends NotesEvent {
  final String notes;
  const PostNOtes({required this.notes});
}

class FetchallNOtes extends NotesEvent {}

class UpdateNOtes extends NotesEvent {
  final String id;
  final String notes;
  const UpdateNOtes({required this.id, required this.notes});
}

class DeleteNOtes extends NotesEvent {
  final String id;
  const DeleteNOtes({required this.id});
}
