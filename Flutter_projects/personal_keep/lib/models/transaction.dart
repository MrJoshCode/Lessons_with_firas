class Transaction {
  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    this.date,
  });

  final String id;
  final String title;
  final double amount;
  DateTime? date;
}
