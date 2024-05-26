import 'package:chat_app/Auth/auth_service.dart';
import 'package:chat_app/ChatServices/chatservices.dart';
import 'package:chat_app/Pages/chat_page.dart';

import 'package:flutter/material.dart';

import '../components/my_drawer.dart';
import '../components/user_tile.dart';

class HomePage extends StatelessWidget {
  HomePage({
    super.key,
  });
  final ChatServices chatServices = ChatServices();
  final AuthService auth = AuthService();

  @override
  Widget build(BuildContext context) {
    // final user = FirebaseAuth.instance.currentUser!;
    // final userEmail = user.email!;
    // final userName = userEmail.split('@')[0];
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text('CHAT IN'),
      ),
      drawer: const MyDrawer(),
      body: displayUsers(),
    );
  }

  Widget displayUsers() {
    return StreamBuilder(
      stream: chatServices.getUsersStream(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Text('Error..');
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text('Loading..');
        }
        return ListView(
          children: snapshot.data!
              .map<Widget>(
                (userData) => buildUserListItem(userData, context),
              )
              .toList(),
        );
      },
    );
  }

  Widget buildUserListItem(
      Map<String, dynamic> userData, BuildContext context) {
    String userEmail = userData['email'];
    String userName = userEmail.split('@')[0];
    if (userData["email"] != auth.getCurrentUser()!.email) {
      return UserTile(
        text: userName,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ChatPage(
                receiverEmail: userName,
                receiverId: userData['uid'],
              ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
