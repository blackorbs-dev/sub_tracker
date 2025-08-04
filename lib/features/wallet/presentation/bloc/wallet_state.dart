part of 'wallet_bloc.dart';

sealed class WalletState extends Equatable {
  const WalletState();

  const factory WalletState.initial() = Initial;
  const factory WalletState.loaded({
    required Wallet wallet
  }) = Loaded;
}

final class Initial extends WalletState {
  const Initial();

  @override
  List<Object> get props => [];
}

final class Loaded extends WalletState{
  final Wallet wallet;
  final String inputAmount;
  final bool isLoading;
  final String? message;

  const Loaded({
    required this.wallet,
    this.inputAmount = '',
    this.isLoading = false,
    this.message
  });

  Loaded copyWith({
    Wallet? wallet,
    String? inputAmount,
    bool? isLoading,
    String? message
  }) => Loaded(
      wallet: wallet ?? this.wallet,
      inputAmount: inputAmount ?? this.inputAmount,
      isLoading: isLoading ?? this.isLoading,
      message: message
  );

  @override
  List<Object?> get props => [wallet, inputAmount, isLoading, message];
}
