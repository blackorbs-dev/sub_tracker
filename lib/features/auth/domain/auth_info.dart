import 'package:equatable/equatable.dart';

class AuthInfo extends Equatable{
  final String name;
  final String email;
  final String password;

  const AuthInfo({
    this.name = '',
    required this.email,
    required this.password
  });

  AuthInfo copyWith({
    String? name,
    String? email,
    String? password
  }){
    return AuthInfo(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password
    );
  }

  static const empty = AuthInfo(email: '', password: '');

  @override
  List<Object?> get props => [name, email, password];

}