import 'package:flutter_laravel_pusher_app/services/data/params/send_message_request_params.dart';
import 'package:flutter_laravel_pusher_app/services/repository/i_message_repository.dart';

class SendMessageUseCase {
  final IMessageRepository repository;

  SendMessageUseCase({required this.repository});

  Future<void> call(SendMessageRequestParams params) => repository.sendMessage(params);
}
