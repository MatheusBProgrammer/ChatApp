import 'dart:io';

import 'package:chat/core/models/app_user.dart';

abstract class AuthService {
  AppUser? get currentUser;

  Stream<AppUser?> get userChanges;

  Future<void> signup(
      String email, String password, String username, File? image);

  Future<void> login(String email, String password);

  Future<void> logout();
}
