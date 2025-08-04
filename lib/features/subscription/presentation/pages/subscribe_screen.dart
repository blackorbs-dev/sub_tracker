import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/core/service/toast_manager.dart';
import 'package:sub_tracker/core/theme/extensions.dart';
import 'package:sub_tracker/features/subscription/domain/models/subscription_plan.dart';
import 'package:sub_tracker/features/subscription/presentation/widgets/billing_switch.dart';
import 'package:sub_tracker/features/subscription/presentation/widgets/sub_plan_card.dart';
import '../bloc/subscription_bloc.dart';

class SubscribeScreen extends StatelessWidget{
  const SubscribeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SubscriptionBloc(context.read()),
        child: const SubscribeView(),
    );
  }
}

class SubscribeView extends StatelessWidget{
  const SubscribeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Choose your plan'),
        backgroundColor: context.theme.colors.background,
        foregroundColor: context.theme.colors.foreground,
      ),
      body: BlocConsumer<SubscriptionBloc, SubscriptionState>(
          builder: (context, state){
            return Column(
                children: [
                  BillingToggle(billingType: state.selectedBillingType),
                  Expanded(
                    child:  AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                      child: ListView.builder(
                        key: ValueKey(state.selectedBillingType),
                        itemCount: SubscriptionPlan.values.length,
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                        itemBuilder: (_, index) {
                          final subPlan = SubscriptionPlan.values[index];
                          return SubPlanCard(
                              subPlan: subPlan,
                              isCurrent: subPlan == state.currentSub?.plan,
                              isSelected: subPlan == state.selectedPlan,
                              billingType: state.selectedBillingType,
                              isLoading:state. isLoading
                          );
                        },
                      )
                    ),
                  )
                ],
              );
          },
          listener: (context, state){
            final message = state.message;
            if(message != null){
              ToastManager().show(context, message);
              context.read<SubscriptionBloc>().add(ClearMessage());
            }
          }
      ),
    );
  }
  
}