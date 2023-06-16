import 'dart:async';
import 'dart:math';
import 'package:chat/core/models/app_user.dart';
import 'package:chat/core/models/chat_message.dart';
import 'package:chat/core/services/chat/chat_service.dart';

class ChatMockService implements ChatService {
  static MultiStreamController<List<ChatMessage>>? _msgStreamController;

  static final List<ChatMessage> _msg = [
   /*ChatMessage(
      id: '8',
      text: 'Sabia não',
      userId: '2',
      userName: 'Marinho',
      userImageURL: 'assets/images/avatar.png',
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      id: '2',
      text: 'Tens vaga no Vasco?',
      userId: '2',
      userName: 'Cristiano Ronaldo',
      userImageURL: 'assets/images/avatar.png',
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      id: '3',
      text: 'AuAuAuAu Au Au',
      userId: '3',
      userName: 'Felipe Melo',
      userImageURL: 'assets/images/avatar.png',
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      id: '4',
      text: 'Olha o chutiiiiiii',
      userId: '4',
      userName: 'Renata Silveira',
      userImageURL: 'assets/images/avatar.png',
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      id: '5',
      text: 'Relaxa Galera, to falando com o messi',
      userId: '5',
      userName: 'Suarez',
      userImageURL: 'assets/images/avatar.png',
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      id: '6',
      text:
          'Se o Gremio tem uma folha de pagamento maior, bateriamos de frente com o Barcelona, Real Madrid e Manchester City do Guardiola.',
      userId: '6',
      userName: 'Renato Gaucho',
      userImageURL: 'assets/images/avatar.png',
      createdAt: DateTime.now(),
    ),
    ChatMessage(
      id: '7',
      text:
          'Tira esse reporter da globo na minha frente se não eu faço um trap',
      userId: '7',
      userName: 'Gabigol',
      userImageURL: 'assets/images/avatar.png',
      createdAt: DateTime.now(),
    ),*/
  ];
  static final Stream<List<ChatMessage>> _msgStream =
      Stream<List<ChatMessage>>.multi((controller) {
    _msgStreamController = controller;
    //this line will send the data to the Stream when the first listener is added
    _msgStreamController?.add(_msg.reversed.toList());
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
    //this line will send the data to the Stream when the first listener is added
    _msgStreamController?.add(_msg.reversed.toList());
    return Future.value(newChatMessage);
  }
}
