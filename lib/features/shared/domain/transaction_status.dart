enum TransactionStatus{
  pending('Pending'),
  successful('Successful'),
  failed('Failed');

  final String name;

  const TransactionStatus(this.name);
}