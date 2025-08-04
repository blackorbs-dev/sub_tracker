import 'package:equatable/equatable.dart';

class SubscriptionOverview extends Equatable{
  final int totalLocations;
  final int totalRenewals;
  final int daysLeft;

  const SubscriptionOverview({
    required this.totalLocations,
    required this.totalRenewals,
    required this.daysLeft
  });

  @override
  List<Object?> get props => [totalLocations, totalRenewals, daysLeft];

}