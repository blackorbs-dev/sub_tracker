import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/core/error/extensions.dart';
import 'package:sub_tracker/core/util/response.dart';
import '../../domain/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class LoginBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;

  LoginBloc(this._authRepository) : super(AuthState()) {
    on<Login>(_onLogin);
    on<BiometricLogin>(_onBiometricLogin);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ResetError>(_onResetError);
  }

  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(authInfo: state.authInfo.copyWith(email: event.email)));
  }

  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit) {
    emit(state.copyWith(authInfo: state.authInfo.copyWith(password: event.password)));
  }

  void _onLogin(Login event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await _authRepository.login(state.authInfo);
    response.onSuccess((_){
      emit(state.copyWith(isAuthenticated: true));
    }).onError((error){
      emit(state.copyWith(errorMessage: error.message()));
    });
    emit(state.copyWith(isLoading: false));
  }

  void _onBiometricLogin(BiometricLogin event, Emitter<AuthState> emit) async {
    emit(state.copyWith(isLoading: true));
    final response = await _authRepository.biometricLogin();
    response.onSuccess((_){
      emit(state.copyWith(isAuthenticated: true));
    }).onError((error){
      emit(state.copyWith(errorMessage: error.message()));
    });
    emit(state.copyWith(isLoading: false));
  }

  void _onResetError(ResetError event, Emitter<AuthState> emit) {
    emit(state.copyWith(errorMessage: null));
  }
}
