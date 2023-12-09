class AdminMessageModel {
  int id;
  int user;
  String subject;
  String message;
  DateTime createdAt;

  AdminMessageModel({
    required this.id,
    required this.user,
    required this.subject,
    required this.message,
    required this.createdAt,
  });

  factory AdminMessageModel.fromJson(Map<String, dynamic> json) {
    return AdminMessageModel(
      id: json['id'] as int,
      user: json['user'] as int,
      subject: json['subject'] as String,
      message: json['message'] as String,
      createdAt: DateTime.parse(json['created_at'] as String),
    );
  }
}
