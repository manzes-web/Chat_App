import 'package:chat_app/Pages/login_page.dart';
import 'package:chat_app/Pages/register_page.dart';
import 'package:flutter/material.dart';

class LoginRegisterToggle extends StatefulWidget {
  const LoginRegisterToggle({super.key});

  @override
  State<LoginRegisterToggle> createState() => _LoginRegisterToggleState();
}

class _LoginRegisterToggleState extends State<LoginRegisterToggle> {
  bool showLoginPage = true;
  void togglePage() {
    setState(() {
      showLoginPage = !showLoginPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLoginPage) {
      return LoginPage(
        onTap: togglePage,
      );
    } else {
      return RegisterPage(
        onTap: togglePage,
      );
    }
  }
}
