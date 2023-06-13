import 'package:chat/core/services/auth/auth_mock_service.dart';
import 'package:chat/pages/loading_page.dart';
import 'package:flutter/material.dart';
import '../core/models/app_user.dart';
import '../core/services/auth/auth_service.dart';
import 'app_page.dart';
import 'auth_page.dart';

class AuthOrAppPage extends StatelessWidget {
  const AuthOrAppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<AppUser?>(
        stream: AuthService().userChanges,
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingPage();
          } else {
            print(snapshot.data);
            return snapshot.hasData ? const AppPage() : const AuthPage();
          }
        },
      ),
    );
  }
}
