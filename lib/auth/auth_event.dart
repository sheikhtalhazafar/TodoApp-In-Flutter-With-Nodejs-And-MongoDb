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
  const RegisterEvent({this.name, this.email, this.password});
}

class LoginEvent extends AuthEvent {
  final String? email;
  final String? password;
  const LoginEvent({this.email, this.password});
}
