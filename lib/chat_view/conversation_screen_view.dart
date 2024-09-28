import 'package:flutter/material.dart';
import 'package:flutter_laravel_pusher_app/chat_view/conversation_screen_controller.dart';
import 'package:get/get.dart';

class ConversationScreenView extends GetView<ConversationScreenController> {
  const ConversationScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Conversation")),
      body: Column(
        children: [
          Expanded(
            child: Obx(
              () => ListView.separated(
                shrinkWrap: true,
                reverse: true,
                itemCount: controller.messageList.length,
                padding: EdgeInsetsDirectional.symmetric(horizontal: 20, vertical: 20),
                separatorBuilder: (_, __) => SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final item = controller.messageList[index];
                  return Text("Message :: [${item.message}] :: [${item.senderId}]");
                },
              ),
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(child: TextFormField(controller: controller.messageEditController)),
                IconButton(
                  onPressed: () => controller.sendMessage(),
                  icon: Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
