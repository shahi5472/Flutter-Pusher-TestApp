import 'package:dio/dio.dart';
import 'package:flutter_laravel_pusher_app/services/data/params/send_message_request_params.dart';
import 'package:flutter_laravel_pusher_app/services/datasource/remote_datasource/i_message_remote_datasource.dart';

class MessageRemoteDataSourceImpl extends IMessageRemoteDataSource {
  final Dio _dio;

  MessageRemoteDataSourceImpl({required Dio dio}) : _dio = dio;

  @override
  Future<void> sendMessage(SendMessageRequestParams params) async {
    final response = await _dio.postUri(
      Uri.parse('{baseUrl}/broadcast'),
      data: params.toJson,
      options: Options(headers: {"X-Socket-Id": params.socketId}),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to send message');
    }
  }
}
