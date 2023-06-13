import 'dart:async';
import 'dart:math';
import 'package:chat/core/models/app_user.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static MultiStreamController<List<ChatMessage>>? _msgStreamController;

  static final List<ChatMessage> _msg = [
    ChatMessage(
      id: '1',
      text: 'Olá, tudo bem?',
      userId: '1',
      userName: 'teste1',
      userImageURL: 'assets/images/avatar.png',
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      id: '2',
      text: 'Olá, tudo bem2?',
      userId: '2',
      userName: 'teste2',
      userImageURL: 'assets/images/avatar.png',
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      id: '3',
      text: 'Olá, tudo bem3?',
      userId: '3',
      userName: 'teste3',
      userImageURL: 'assets/images/avatar.png',
      createdAt: DateTime.now(),
    ),
  ];
  static final Stream<List<ChatMessage>> _msgStream =
      Stream<List<ChatMessage>>.multi((controller) {
    _msgStreamController = controller;
    //this line will send the data to the Stream when the first listener is added
    _msgStreamController?.add(_msg);
  });

  @override
  Stream<List<ChatMessage>> messagesStream() {
    //This getter will be used to listen to the stream in the StreamBuilder
    return _msgStream;
  }

  @override
  Future<ChatMessage> saveMessage(String message, AppUser user) {
    final newChatMessage = ChatMessage(
      id: Random().nextDouble().toString(),
      text: message,
      userId: user.id,
      userName: user.name,
      userImageURL: user.imageURL,
      createdAt: DateTime.now(),
    );
    _msg.add(newChatMessage);
    _msgStreamController?.add(_msg);
    return Future.value(newChatMessage);
  }
}
