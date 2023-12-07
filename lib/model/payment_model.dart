class PaymentModel {
  final int id;
  final double amount;
  final String transactionType;
  final String orderId;
  final bool isSuccess;
  final DateTime createdAt;
  final int wallet;
  final int driver;

  PaymentModel({
    required this.id,
    required this.amount,
    required this.transactionType,
    required this.orderId,
    required this.isSuccess,
    required this.createdAt,
    required this.wallet,
    required this.driver,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id'],
      amount: json['amount'].toDouble() / 100,
      transactionType: json['transaction_type'],
      orderId: json['order_id'],
      isSuccess: json['is_success'],
      createdAt: DateTime.parse(json['created_at']),
      wallet: json['wallet'],
      driver: json['driver'],
    );
  }
}
