import 'package:equatable/equatable.dart';


class AuthState extends Equatable {
  final String status;
  const AuthState({this.status = ''});

  AuthState copyWith({
    String? status,
  }) {
    return AuthState(status: status ?? this.status);
  }

  @override
  List<Object> get props => [status];
}
