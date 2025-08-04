import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/core/error/extensions.dart';
import 'package:sub_tracker/core/util/response.dart';
import 'package:sub_tracker/features/wallet/domain/repository/wallet_repository.dart';

import '../../domain/models/wallet.dart';

part 'wallet_event.dart';
part 'wallet_state.dart';

class WalletBloc extends Bloc<WalletEvent, WalletState> {
  final WalletRepository _repository;

  WalletBloc(this._repository) : super(WalletState.initial()) {
    on<Initialize>(_onInitialize);
    on<FundWallet>(_onFundWallet);
    on<ResetError>(_onResetError);
    on<LoadData>(_onLoadData);
    on<InputAmountChanged>(_onInputAmountChanged);

    add(Initialize());
  }

  Future<void> _onInitialize(Initialize event, Emitter<WalletState> emit) async{
    final stream = await _repository.getWalletStream();
    return emit.onEach(
      stream,
      onData: (wallet){
        add(LoadData(wallet));
      },
      onError: (error, stacktrace){
        error.printDebug(tag: 'Wallet stream error');
        stacktrace.printDebug();
      }
    );
  }

  void _onLoadData(LoadData event, Emitter<WalletState> emit){
    emit(
        switch(state){
          Initial() => WalletState.loaded(wallet: event.wallet),
          Loaded() => loadedState.copyWith(wallet: event.wallet),
        }
    );
  }

  void _onFundWallet(FundWallet event, Emitter<WalletState> emit) async{
    emit(loadedState.copyWith(isLoading: true));
    final response = await _repository.fundWallet(double.parse(loadedState.inputAmount));
    response.onSuccess((_){
      emit(loadedState.copyWith(inputAmount: '', message: 'Wallet top-up was successful'));
    }).onError((error){
      emit(loadedState.copyWith(message: error.message()));
    });
    emit(loadedState.copyWith(isLoading: false));
  }

  void _onInputAmountChanged(InputAmountChanged event, Emitter<WalletState> emit){
    emit(loadedState.copyWith(inputAmount: event.amount));
  }

  void _onResetError(ResetError event, Emitter<WalletState> emit){
    emit(loadedState.copyWith(message: null));
  }

  Loaded get loadedState => state as Loaded;
}
