import 'package:chat_app/Auth/auth_service.dart';
import 'package:chat_app/ChatServices/chatservices.dart';
import 'package:chat_app/components/chat_bubble.dart';
import 'package:chat_app/components/textfield.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatelessWidget {
  final String receiverEmail;
  final String receiverId;
  ChatPage({
    super.key,
    required this.receiverEmail,
    required this.receiverId,
  });

  final TextEditingController messageController = TextEditingController();
  final ChatServices chatServices = ChatServices();
  final AuthService authService = AuthService();

  void sendMessage() async {
    if (messageController.text.isNotEmpty) {
      await chatServices.sendMessage(receiverId, messageController.text);
      messageController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Text(receiverEmail),
      ),
      body: Container(
        color: Theme.of(context).colorScheme.tertiary,
        child: Column(
          children: [
            Expanded(
              child: buildMessageList(),
            ),
            buildUserInput(context)
          ],
        ),
      ),
    );
  }

  Widget buildMessageList() {
    String senderId = authService.getCurrentUser()!.uid;
    return StreamBuilder(
      stream: chatServices.getMessages(receiverId, senderId),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error..');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('loading..');
        }
        return ListView(
          children: snapshot.data!.docs
              .map((docs) => buildMessageItem(docs))
              .toList(),
        );
      },
    );
  }

  Widget buildMessageItem(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    bool isCurrentUser = data['senderId'] == authService.getCurrentUser()!.uid;
    var alignment =
        isCurrentUser ? Alignment.centerRight : Alignment.centerLeft;
    return Container(
      alignment: alignment,
      child: Column(
        crossAxisAlignment:
            isCurrentUser ? CrossAxisAlignment.end : CrossAxisAlignment.start,
        children: [
          ChatBubble(
            isCurrentUser: isCurrentUser,
            message: data['message'],
          )
        ],
      ),
    );
  }

  Widget buildUserInput(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Row(
        children: [
          Expanded(
            child: MyTextfield(
              labeltext: 'Enter your message..',
              obscureText: false,
              controller: messageController,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(5),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Theme.of(context).colorScheme.tertiary,
            ),
            child: IconButton(
              onPressed: sendMessage,
              icon: const Icon(Icons.send),
            ),
          ),
        ],
      ),
    );
  }
}
