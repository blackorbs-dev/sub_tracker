import 'dart:ui';
import '../domain/models/subscription_plan.dart';

extension Colors on SubscriptionPlan{
  List<Color> getColors() => switch(this){
    SubscriptionPlan.basic => const[Color(0xFF27272a),Color(0xFF404040)],
    SubscriptionPlan.standard => const[Color(0xFF8b5cf6), Color(0xFFa78bfa)],
    SubscriptionPlan.premium => const[Color(0xFF7f1d1d), Color(0xFF020617)],
  };

  String get iconAsset => switch(this){
    SubscriptionPlan.basic => 'assets/icons/shield.svg',
    SubscriptionPlan.standard => 'assets/icons/star.svg',
    SubscriptionPlan.premium => 'assets/icons/crown.svg',
  };
}

Color colorFromIndex(int index) {
  const colors = <Color>[
    Color(0xFFf59e0b),
    Color(0xFF0ea5e9),
    Color(0xFFa78bfa),
    Color(0xFF7f1d1d),
    Color(0xFF404040),
    Color(0xFF8b5cf6),
  ];
  return colors[index % colors.length];
}