import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/core/service/toast_manager.dart';
import 'package:sub_tracker/core/theme/extensions.dart';
import 'package:sub_tracker/features/shared/widgets/primary_button.dart';

import '../../../auth/presentation/widgets/input_title.dart';
import '../../../shared/widgets/text_field.dart';
import '../bloc/wallet_bloc.dart';

class AddFundPopup extends StatefulWidget {
  const AddFundPopup({super.key});

  @override
  State<StatefulWidget> createState() => AddFundState();
}

class AddFundState extends State<AddFundPopup>{

  late TextEditingController _controller ;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.fromLTRB(16, 20, 16, 48+MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'Add Funds', textAlign: TextAlign.center,
            style: context.theme.textTheme.titleLarge
              .withColor(context.theme.colors.foreground),
          ),
          const SizedBox(height: 16),
          InputTitle(text: 'Amount (\$)'),
          TextInputField(
              hint: 'Enter amount',
              onChanged: (amount){
                context.read<WalletBloc>().add(InputAmountChanged(amount));
              },
              inputType: TextInputType.number,
              controller: _controller,
          ),
          const SizedBox(height: 22,),
          BlocConsumer<WalletBloc, WalletState>(
              builder: (context, state){
                return PrimaryButton(
                    text: 'Fund Wallet',
                    isLoading: (state as Loaded).isLoading,
                    enabled: state.inputAmount.isNotEmpty,
                    onPressed: (){
                      context.read<WalletBloc>().add(FundWallet());
                    }
                );
              },
              listener: (context, state){
                if(state case Loaded(:final inputAmount, message:final errorMessage)) {
                  if(inputAmount.isEmpty) {
                    _controller.value = TextEditingValue();
                  }
                  if(errorMessage != null){
                    ToastManager().show(context, errorMessage);
                    context.read<WalletBloc>().add(ResetError());
                  }
                }
              }
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

}