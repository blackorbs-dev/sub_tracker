part of 'sub_history_cubit.dart';

sealed class SubHistoryState extends Equatable {
  const SubHistoryState();

  const factory SubHistoryState.initial() = Initial;
}

final class Initial extends SubHistoryState {
  const Initial();
  @override
  List<Object> get props => [];
}

final class Loaded extends SubHistoryState{
  final List<Subscription> subscriptions;
  final Map<Location, Color> locationColorMap;
  final Set<Marker> markers;

  const Loaded(this.subscriptions, this.locationColorMap, this.markers);

  @override
  List<Object?> get props => [subscriptions, locationColorMap, markers];
}



