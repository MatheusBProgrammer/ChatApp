import 'dart:io';
import 'dart:async';
import 'dart:math';
import 'package:chat/core/models/app_user.dart';
import 'package:chat/core/services/auth/auth_service.dart';

class AuthMockService implements AuthService {
  static const _defaultUser = AppUser(
    id: '456',
    name: 'Matheus',
    email: 'matheus@',
    imageURL: 'assets/images/avatar.png',
  );

  static final Map<String, AppUser> _users = {
    _defaultUser.email: _defaultUser,
  };
  static AppUser? _currentUser;
  static MultiStreamController<AppUser?>? _controller;
  static final _userStream = Stream<AppUser?>.multi((controller) {
    _controller = controller;
    _updateUser(_defaultUser);
  });

  @override
  AppUser? get currentUser {
    return _currentUser;
  }

  @override
  Stream<AppUser?> get userChanges {
    return _userStream;
  }

  @override
  Future<void> signup(
      String name,
      String email,
      String password,
      File? image,
      ) async {
    final newUser = AppUser(
      id: Random().nextDouble().toString(),
      name: name,
      email: email,
      imageURL: image?.path ?? 'assets/images/avatar.png',
    );

    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  @override
  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  @override
  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(AppUser? user) {
    _currentUser = user;
    _controller?.add(_currentUser);
  }
}
