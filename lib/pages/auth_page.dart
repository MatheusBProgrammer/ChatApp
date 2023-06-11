import 'package:chat/core/services/auth/auth_mock_service.dart';
import 'package:flutter/material.dart';
import '../components/auth_form.dart';
import '../core/models/auth_form_data.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLoading = false;

  Future<void> _handleSubmit(AuthFormData formData) async {
    try {
      setState(() {
        isLoading = true;
      });
      if (formData.isLogin) {
        //login
        await AuthMockService().login(formData.email, formData.password);
      } else {
        //signup
        print('signup');
        await AuthMockService().signup(
          formData.name,
          formData.email,
          formData.password,
          formData.image,
        );
        print('executou');
      }
    } catch (error) {
      //this line will be executed if the setState fails
    }
    //this line will be executed if the setState fails, independently of the error
    finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Center(
            child: SingleChildScrollView(
              child: AuthForm(
                onSubmit: _handleSubmit,
              ),
            ),
          ),
          // if (isLoading)
          //   Container(
          //     height: double.infinity,
          //     width: double.infinity,
          //     decoration: BoxDecoration(
          //         color: Colors.black54,
          //         borderRadius: BorderRadius.circular(10)),
          //     child: Center(
          //       child: CircularProgressIndicator(),
          //     ),
          //   )
        ],
      ),
    );
  }
}
