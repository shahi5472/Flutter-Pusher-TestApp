import 'package:flutter_laravel_pusher_app/services/data/params/send_message_request_params.dart';

abstract class IMessageRepository {
  Future<void> sendMessage(SendMessageRequestParams params);
}
