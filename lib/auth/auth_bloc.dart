import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_nodejs/auth/auth_event.dart';
import 'package:todo_nodejs/auth/auth_state.dart';
import 'package:todo_nodejs/services/authservices.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final _auth = AuthService();

  AuthBloc() : super(const AuthState()) {
    on<RegisterEvent>(registerUser);
    on<LoginEvent>(loginUser);
  }

  Future<void> registerUser(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(state.copyWith(status: "loading"));

    try {
      final result = await _auth.signup(
        event.name!,
        event.email!,
        event.password!,
        event.path!
      );
      print(result);
      if (result == 'success') {
        emit(state.copyWith(status: "success"));
      } else {
        emit(state.copyWith(status: "Signup Failed"));
      }
    } catch (e) {
      emit(state.copyWith(status: e.toString()));
    }
  }

  Future<void> loginUser(LoginEvent event, Emitter<AuthState> emit) async {
    emit(state.copyWith(status: "loading"));
    try {
      final result = await _auth.login(event.email!, event.password!,);
      print(result);
      if (result == 'success') {
        emit(state.copyWith(status: "success"));
      } else {
        emit(state.copyWith(status: "Login Failed"));
      }
    } catch (e) {
      emit(state.copyWith(status: e.toString()));
    }
  }
}
