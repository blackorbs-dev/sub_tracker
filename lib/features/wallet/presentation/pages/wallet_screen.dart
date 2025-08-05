import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/core/theme/extensions.dart';
import 'package:sub_tracker/features/wallet/presentation/widgets/balance_box.dart';
import 'package:sub_tracker/features/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:sub_tracker/features/wallet/presentation/widgets/add_fund_popup.dart';
import 'package:sub_tracker/features/wallet/presentation/widgets/transaction_card.dart';

import '../../../shared/presentation/widgets/center_text.dart';
import '../../../shared/presentation/widgets/svg_icon.dart';

class WalletScreen extends StatelessWidget{
  const WalletScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => WalletBloc(context.read()),
        child: const WalletView(),
    );
  }

}

class WalletView extends StatelessWidget{
  const WalletView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wallet'),
        backgroundColor: context.theme.colors.background,
        foregroundColor: context.theme.colors.foreground,
      ),
      body: BlocBuilder<WalletBloc, WalletState>(
          builder: (context, state) {
            return switch(state){
              Initial() => const Center(child: CircularProgressIndicator(),),
              Loaded(:final wallet) => Padding(
                padding: const EdgeInsets.only(left: 16, top: 16, right: 16),
                child: Column(
                  children: [
                    BalanceBox(
                        balance: wallet.balance,
                        balanceThisMonth: wallet.totalBalanceThisMonth
                    ),
                    OutlinedButton(
                      onPressed: (){
                        _showAddFundPopup(context);
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: context.theme.colors.foreground,
                        backgroundColor: context.theme.colors.darkRing,
                        textStyle: context.theme.textTheme.titleMedium,
                        side: BorderSide(width: 2, color: context.theme.colors.darkMutedForeground),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        padding: const EdgeInsets.all(16),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SvgIcon('assets/icons/plus.svg', color: context.theme.colors.foreground,),
                          const SizedBox(width: 4),
                          Text('Add Funds',)
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 28),
                        child: Text(
                          'Recent Transactions',
                          style: context.theme.textTheme.titleLarge
                              .withColor(context.theme.colors.foreground),
                        ),
                      ),
                    ),
                    wallet.transactions.isEmpty
                        ? const Padding(
                        padding: EdgeInsets.only(top: 32),
                        child: CenterText('You haven\'t made any transaction')
                    )
                    : Expanded(child: ListView.builder(
                        itemCount: wallet.transactions.length,
                        itemBuilder: (_, index) {
                          return TransactionCard(
                              transaction: wallet.transactions[index]
                          );
                        }
                    ))
                  ],
                ),
              ),
            };
          }
      )
    );
  }

  void _showAddFundPopup(BuildContext context) async{
    final walletBloc = context.read<WalletBloc>();
    await showModalBottomSheet(
      isScrollControlled: true,
        context: context,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(22)
          ),
        ),
        builder: (_){
          return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocProvider.value(
                      value: walletBloc,
                      child: const AddFundPopup(),
                  )
                ],
              );
        }
    );
    walletBloc.add(const InputAmountChanged(''));
  }

}