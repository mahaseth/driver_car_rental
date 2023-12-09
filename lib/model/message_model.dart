class Message {
  final String text;
  final bool isMe;
  final int receiver;

  Message({required this.text, required this.isMe, required this.receiver});

  factory Message.fromJson(Map<String, dynamic> json, int id) {
    return Message(
      text: json['message'] ?? "",
      isMe: json['sender'] == id,
      receiver: json['receiver'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['message'] = text;
    data['sender'] = isMe;

    return data;
  }
}
