import 'package:equatable/equatable.dart';

import '../../domain/models/auth_info.dart';

class AuthState extends Equatable {
  const AuthState({
    this.authInfo = AuthInfo.empty,
    this.isLoading = false,
    this.isAuthenticated = false,
    this.errorMessage
  });

  final AuthInfo authInfo;
  final bool isLoading;
  final bool isAuthenticated;
  final String? errorMessage;

  AuthState copyWith({
    AuthInfo? authInfo,
    bool? isLoading,
    bool? isAuthenticated,
    String? errorMessage
  }){
    return AuthState(
      authInfo: authInfo ?? this.authInfo,
      isLoading: isLoading ?? this.isLoading,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      errorMessage: errorMessage
    );
  }

  @override
  List<Object?> get props => [authInfo, isLoading, isAuthenticated, errorMessage];
}
