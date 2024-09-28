class MessageResponseModel {
  final String senderId;
  final String receiverId;
  final String message;
  final String dateTime;

  MessageResponseModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.dateTime,
  });

  factory MessageResponseModel.fromJson(Map<String, dynamic> json) {
    return MessageResponseModel(
      senderId: json["sender_id"] ?? "",
      receiverId: json["receiver_id"] ?? "",
      message: json["message"] ?? "",
      dateTime: json["date_time"] ?? "",
    );
  }

  factory MessageResponseModel.empty() {
    return MessageResponseModel(
      senderId: "",
      receiverId: "",
      message: "",
      dateTime: "",
    );
  }

  factory MessageResponseModel.parse({
    required String senderId,
    required String receiverId,
    required String message,
  }) {
    return MessageResponseModel(
      senderId: senderId,
      receiverId: receiverId,
      message: message,
      dateTime: DateTime.now().toUtc().toIso8601String(),
    );
  }
}
