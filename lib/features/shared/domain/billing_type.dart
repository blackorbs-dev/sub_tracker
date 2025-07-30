enum BillingType{
  monthly('Monthly'),
  quarterly('Quarterly');

  final String name;

  const BillingType(this.name);
}