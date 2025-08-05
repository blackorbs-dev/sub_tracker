import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/core/util/constants.dart';
import '../../../../router/routes.dart';
import '../../../dashboard/presentation/pages/dashboard_screen.dart';
import '../../../subscription/presentation/pages/sub_history_screen.dart';
import '../../../subscription/presentation/pages/subscribe_screen.dart';
import '../../../wallet/presentation/pages/wallet_screen.dart';
import '../cubit/home_cubit.dart';

class HomeScreen extends StatelessWidget{
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints){
          if(constraints.maxWidth < Breakpoints.mobile){
            return const DashboardScreen();
          }
          return Row(
            children: [
              const Expanded(child: DashboardScreen()),
              Expanded(
                  child: BlocBuilder<HomeCubit, String>(
                      builder: (context, screen){
                        return AnimatedSwitcher(
                          duration: Duration(milliseconds: 400),
                          child: switch(screen){
                            Screen.subscribe => const SubscribeScreen(
                              key: ValueKey(Screen.subscribe),
                            ),
                            Screen.subHistory => const SubHistoryScreen(
                              key: ValueKey(Screen.subHistory),
                            ),
                            _ => const WalletScreen(
                              key: ValueKey(Screen.wallet),
                            ),
                          },
                        );
                      }
                  )
              )
            ],
          );
        }
    );
  }
}