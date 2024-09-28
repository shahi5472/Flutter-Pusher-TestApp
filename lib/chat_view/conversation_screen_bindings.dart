import 'package:dio/dio.dart';
import 'package:flutter_laravel_pusher_app/chat_view/conversation_screen_controller.dart';
import 'package:flutter_laravel_pusher_app/services/datasource/remote_datasource/i_message_remote_datasource.dart';
import 'package:flutter_laravel_pusher_app/services/datasource/remote_datasource/message_remote_datasource_impl.dart';
import 'package:flutter_laravel_pusher_app/services/repository/i_message_repository.dart';
import 'package:flutter_laravel_pusher_app/services/repository/message_repository_impl.dart';
import 'package:flutter_laravel_pusher_app/services/use_case/SendMessageUseCase.dart';
import 'package:get/get.dart';

class ConversationScreenBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<IMessageRemoteDataSource>(() => MessageRemoteDataSourceImpl(dio: Dio()));
    Get.lazyPut<IMessageRepository>(() => MessageRepositoryImpl(remoteDataSource: Get.find<IMessageRemoteDataSource>()));
    Get.lazyPut<SendMessageUseCase>(() => SendMessageUseCase(repository: Get.find<IMessageRepository>()));
    Get.lazyPut<ConversationScreenController>(() => ConversationScreenController(sendMessageUseCase: Get.find<SendMessageUseCase>()));
  }
}
