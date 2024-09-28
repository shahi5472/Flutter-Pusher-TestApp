import 'package:flutter_laravel_pusher_app/services/data/params/send_message_request_params.dart';
import 'package:flutter_laravel_pusher_app/services/datasource/remote_datasource/i_message_remote_datasource.dart';
import 'package:flutter_laravel_pusher_app/services/repository/i_message_repository.dart';

class MessageRepositoryImpl extends IMessageRepository {
  final IMessageRemoteDataSource _remoteDataSource;

  MessageRepositoryImpl({required IMessageRemoteDataSource remoteDataSource}) : _remoteDataSource = remoteDataSource;

  @override
  Future<void> sendMessage(SendMessageRequestParams params) async {
    return await _remoteDataSource.sendMessage(params);
  }
}
