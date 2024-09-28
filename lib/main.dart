import 'package:flutter/material.dart';
import 'package:flutter_laravel_pusher_app/chat_view/conversation_screen_bindings.dart';
import 'package:flutter_laravel_pusher_app/chat_view/conversation_screen_view.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Laravel Pusher App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: routes,
    );
  }

  static get routes => [
        GetPage(
          name: '/',
          page: () => ConversationScreenView(),
          binding: ConversationScreenBindings(),
        ),
      ];
}
