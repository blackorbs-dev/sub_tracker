import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sub_tracker/core/error/extensions.dart';
import 'package:sub_tracker/core/util/response.dart';
import 'package:sub_tracker/features/subscription/domain/models/subscription_plan.dart';
import 'package:sub_tracker/features/subscription/domain/repository/subscription_repository.dart';

import '../../../../core/util/object.dart';
import '../../domain/models/billing_method.dart';
import '../../domain/models/billing_type.dart';
import '../../domain/models/subscription.dart';

part 'subscription_event.dart';
part 'subscription_state.dart';

class SubscriptionBloc extends Bloc<SubscriptionEvent, SubscriptionState> {
  final SubscriptionRepository _repository;

  SubscriptionBloc(this._repository) : super(const SubscriptionState()) {
    on<Subscribe>(_onSubscribe);
    on<Initialize>(_onInitialize);
    on<ClearMessage>(_onClearMessage);
    on<CancelSubscription>(_onCancelSubscription);
    on<BillingTypeChanged>(_onBillingTypeChanged);

    add(Initialize());
  }

  Future<void> _onInitialize(Initialize event, Emitter<SubscriptionState> emit) async{
    return emit.onEach(
        (await _repository.getCurrentSubscription()),
        onData: (currentSub){
          emit(state.copyWith(currentSub: currentSub));
        }
    );
  }

  void _onBillingTypeChanged(BillingTypeChanged event, Emitter<SubscriptionState> emit){
    emit(state.copyWith(selectedBillingType: event.billingType));
  }

  void _onSubscribe(Subscribe event, Emitter<SubscriptionState> emit) async{
    emit(state.copyWith(isLoading: true, selectedPlan: event.subPlan));
    final response = await _repository.subscribe(
        event.subPlan,
        state.selectedBillingType,
        BillingMethod.userInitiated
    );
    response.onSuccess((_){
      emit(state.copyWith(message: 'Subscription was successful'));
    }).onError((error){
      emit(state.copyWith(message: error.message()));
    });
    emit(state.copyWith(isLoading: false));
  }

  void _onCancelSubscription(CancelSubscription event, Emitter<SubscriptionState> emit) async{
    emit(state.copyWith(isLoading: true, selectedPlan: state.currentSub?.plan));
    final response = await _repository.cancelSubscription();
    response.onSuccess((_){
      emit(state.copyWith(
          currentSub: null,
          message: 'Subscription cancelled successfully'
      ));
    }).onError((error){
      emit(state.copyWith(message: error.message()));
    });
    emit(state.copyWith(isLoading: false));
  }

  void _onClearMessage(ClearMessage event, Emitter<SubscriptionState> emit){
    emit(state.copyWith(message: null));
  }
}
