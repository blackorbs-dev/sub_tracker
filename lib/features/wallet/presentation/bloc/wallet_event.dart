part of 'wallet_bloc.dart';

sealed class WalletEvent extends Equatable {
  const WalletEvent();
}

final class Initialize extends WalletEvent{
  @override
  List<Object?> get props => [];
}

final class LoadData extends WalletEvent{
  final Wallet wallet;
  const LoadData(this.wallet);

  @override
  List<Object?> get props => [wallet];
}

final class FundWallet extends WalletEvent{
  @override
  List<Object?> get props => [];
}

final class InputAmountChanged extends WalletEvent{
  final String amount;
  const InputAmountChanged(this.amount);

  @override
  List<Object?> get props => [amount];
}

final class ResetError extends WalletEvent{
  @override
  List<Object?> get props => [];
}
