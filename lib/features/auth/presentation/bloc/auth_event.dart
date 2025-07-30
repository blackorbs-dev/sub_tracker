import 'package:equatable/equatable.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();
}

final class NameChanged extends AuthEvent {
  final String name;

  const NameChanged(this.name);

  @override
  List<Object?> get props => [name];
}

final class EmailChanged extends AuthEvent {
  final String email;

  const EmailChanged(this.email);

  @override
  List<Object?> get props => [email];
}

final class PasswordChanged extends AuthEvent {
  final String password;

  const PasswordChanged(this.password);

  @override
  List<Object?> get props => [password];
}

final class BiometricLogin extends AuthEvent {
  const BiometricLogin();

  @override
  List<Object?> get props => [];
}

final class Login extends AuthEvent {
  const Login();

  @override
  List<Object?> get props => [];
}

final class Signup extends AuthEvent {
  const Signup();

  @override
  List<Object?> get props => [];
}

final class ResetError extends AuthEvent {
  const ResetError();

  @override
  List<Object?> get props => [];
}
