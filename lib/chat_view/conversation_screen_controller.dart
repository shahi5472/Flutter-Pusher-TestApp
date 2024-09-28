import 'package:flutter/cupertino.dart';
import 'package:flutter_laravel_pusher_app/services/data/message_response_model.dart';
import 'package:flutter_laravel_pusher_app/services/data/params/send_message_request_params.dart';
import 'package:flutter_laravel_pusher_app/services/use_case/SendMessageUseCase.dart';
import 'package:get/get.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

const PUSHER_APP_KEY = "";
const PUSHER_APP_CLUSTER = "";

class ConversationScreenController extends GetxController {
  final SendMessageUseCase sendMessageUseCase;

  ConversationScreenController({required this.sendMessageUseCase});

  final TextEditingController messageEditController = TextEditingController();

  RxList<MessageResponseModel> messageList = <MessageResponseModel>[].obs;

  final PusherChannelsFlutter pusher = PusherChannelsFlutter.getInstance();

  @override
  void onInit() {
    _initPusher();
    super.onInit();
  }

  @override
  void onClose() {
    pusher.disconnect();
    super.onClose();
  }

  void _initPusher() async {
    try {
      debugPrint("ConversationScreenController :: initPusher :: try");

      await pusher.init(
        apiKey: PUSHER_APP_KEY,
        cluster: PUSHER_APP_CLUSTER,
        onConnectionStateChange: _onConnectionStateChange,
        onError: _onError,
        onEvent: _onMessageReceived,
      );
      await pusher.subscribe(channelName: "public");
      await pusher.connect();
    } catch (e) {
      debugPrint("ConversationScreenController :: initPusher :: Error :: [$e]");
    }
  }

  void _onConnectionStateChange(dynamic currentState, dynamic previousState) {
    debugPrint('ConversationScreenController :: Connection state changed from $previousState to $currentState');
  }

  // Callback for Pusher errors
  void _onError(String message, int? code, dynamic e) {
    debugPrint('ConversationScreenController ::  Error: $message code: $code exception: $e');
  }

  void _onMessageReceived(PusherEvent event) {
    debugPrint('ConversationScreenController :: _onMessageReceived :: Event: [$event]');
    debugPrint('ConversationScreenController :: _onMessageReceived :: Event: [${event.runtimeType}]');
    debugPrint('ConversationScreenController :: _onMessageReceived :: Event: [${event.data}]');
    debugPrint('ConversationScreenController :: _onMessageReceived :: Event: [${event.userId}]');
    debugPrint('ConversationScreenController :: _onMessageReceived :: Event: [${event.channelName}]');
    debugPrint('ConversationScreenController :: _onMessageReceived :: Event: [${event.eventName}]');

    if (event.eventName == 'chat') {
      // Check if the event is of type 'chat'
      if (event.data != null) {
        try {
          // Convert the JSON into the message model
          final incomingMessage = MessageResponseModel.parse(
            senderId: '',
            receiverId: '',
            message: event.data,
          );

          debugPrint('ConversationScreenController :: _onMessageReceived :: Event-data: [${event.data}]');

          // Insert the new message at the beginning of the message list
          messageList.insert(0, incomingMessage);
        } catch (e) {
          debugPrint('Error parsing message data: $e');
        }
      }
    } else {
      debugPrint('Invalid event received: $event');
    }
  }

  void sendMessage() async {
    String message = messageEditController.text;
    final socketId = await pusher.getSocketId();

    SendMessageRequestParams params = SendMessageRequestParams(
      senderId: "",
      receiverId: "",
      message: message,
      socketId: socketId,
    );
    await sendMessageUseCase.call(params);
    messageList.insert(0, MessageResponseModel.parse(senderId: "", receiverId: "", message: message));
    messageEditController.clear();
  }
}
