enum SubscriptionPlan{
  basic(
      'Basic', 9.99, [
        'Up to 5 subscriptions','Basic notifications',
        'Location tracking','Email support'
      ]
  ),
  standard(
      'Standard', 19.99, [
        'Up to 15 subscriptions','Advanced notifications',
        'Location history','Priority support','Usage analytics'
      ]
  ),
  premium(
      'Premium', 29.99, [
        'Unlimited subscriptions','Smart notifications',
        'Advanced analytics','24/7 support','Export Data','Family sharing'
      ]
  );

  final String name;
  final double price;
  final List<String> perks;

  const SubscriptionPlan(this.name, this.price, this.perks);
}