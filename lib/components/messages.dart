import 'package:chat/core/models/chat_message.dart';
import 'package:flutter/material.dart';
import '../core/services/chat/chat_service.dart';

class Messages extends StatelessWidget {
  const Messages({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: ChatService().messagesStream(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData ||
            (snapshot.data as List<ChatMessage>).isEmpty) {
          return Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.sentiment_neutral_outlined,
                    size: 80,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Você tem um total de 0 mensagens',
                    style: TextStyle(fontSize: 22),
                  ),
                ],
              ),
            ),
          );
        } else {
          final messages = snapshot.data as List<ChatMessage>;
          return Container(
            height: 300,
            child: ListView.builder(
              reverse: true,
                itemCount: messages.length,
                itemBuilder: (_, index) {
                  return InkWell(
                    onTap: () {},
                    child: ListTile(
                        title: Text(messages[index].userName),
                        subtitle: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(messages[index].text),
                          ],
                        ),
                        leading: CircleAvatar(
                          backgroundImage:
                              AssetImage(messages[index].userImageURL),
                        )),
                  );
                }),
          );
        }
      },
    );
  }
}
