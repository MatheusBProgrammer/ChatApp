import 'package:chat/core/services/auth/auth_mock_service.dart';
import 'package:flutter/material.dart';

class AppPage extends StatelessWidget {
  const AppPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('AppPage'),
              TextButton(onPressed: (){
                AuthMockService().logout();
              }, child: Text('Logout'))
            ],
          ),
        ),
      ),
    );
  }
}
