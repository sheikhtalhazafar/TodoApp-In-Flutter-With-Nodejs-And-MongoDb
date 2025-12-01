import 'package:equatable/equatable.dart';

class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends AuthEvent {
  final String? name;
  final String? email;
  final String? password;
  final String? path;
  const RegisterEvent({this.name, this.email, this.password, this.path});
}

class LoginEvent extends AuthEvent {
  final String? email;
  final String? password;
  const LoginEvent({this.email, this.password});
}
