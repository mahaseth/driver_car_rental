class BankAccountModel {
  late int id;
  late String account;
  late String ifsc;
  late String name;
  late String others;
  late int driver;

  BankAccountModel({
    required this.id,
    required this.account,
    required this.ifsc,
    required this.name,
    required this.others,
    required this.driver,
  });

  factory BankAccountModel.fromJson(Map<String, dynamic> json) {
    return BankAccountModel(
      id: json['id'] as int,
      account: json['account'] as String,
      ifsc: json['ifsc'] as String,
      name: json['name'] as String,
      others: json['others'] ?? "",
      driver: json['driver'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'account': account,
      'ifsc': ifsc,
      'name': name,
      'others': others,
      'driver': driver,
    };
  }
}
