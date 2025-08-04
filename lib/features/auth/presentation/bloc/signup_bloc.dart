import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/core/error/extensions.dart';
import 'package:sub_tracker/core/util/response.dart';

import '../../domain/auth_repository.dart';
import 'auth_event.dart';
import 'auth_state.dart';

class SignupBloc extends Bloc<AuthEvent, AuthState>{
  final AuthRepository _authRepository;
  
  SignupBloc(this._authRepository) : super(AuthState()){
    on<Signup>(_onSignup);
    on<NameChanged>(_onNameChanged);
    on<EmailChanged>(_onEmailChanged);
    on<PasswordChanged>(_onPasswordChanged);
    on<ResetError>(_onResetError);
  }
  
  void _onNameChanged(NameChanged event, Emitter<AuthState> emit){
    emit(state.copyWith(authInfo: state.authInfo.copyWith(name: event.name)));
  }
  
  void _onEmailChanged(EmailChanged event, Emitter<AuthState> emit){
    emit(state.copyWith(authInfo: state.authInfo.copyWith(email: event.email)));
  }
  
  void _onPasswordChanged(PasswordChanged event, Emitter<AuthState> emit){
    emit(state.copyWith(authInfo: state.authInfo.copyWith(password: event.password)));
  }
  
  void _onSignup(Signup event, Emitter<AuthState> emit) async{
    emit(state.copyWith(isLoading: true));
    final response = await _authRepository.signup(state.authInfo);
    response.onSuccess((_){
      emit(state.copyWith(isAuthenticated: true));
    }).onError((error){
      emit(state.copyWith(errorMessage: error.message()));
    });
    emit(state.copyWith(isLoading: false));
  }

  void _onResetError(ResetError event, Emitter<AuthState> emit){
    emit(state.copyWith(errorMessage: null));
  }
}