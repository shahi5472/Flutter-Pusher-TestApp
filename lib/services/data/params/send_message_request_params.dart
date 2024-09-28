class SendMessageRequestParams {
  final String message;
  final String senderId;
  final String receiverId;
  final String socketId;

  SendMessageRequestParams({
    required this.senderId,
    required this.receiverId,
    required this.message,
    this.socketId = "",
  });

  Map<String, dynamic> get toJson => {
        "sender_id": senderId,
        "receiver_id": receiverId,
        "message": message,
      };
}
