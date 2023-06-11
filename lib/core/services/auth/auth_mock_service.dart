import 'dart:async';
import 'dart:io';
import 'dart:math';

import '../../models/app_user.dart';
import 'auth_service.dart';

class AuthMockService implements AuthService {
  static const _defaultUser = AppUser(
      id: '0',
      name: 'teste',
      email: 'teste@teste.com',
      imageURL: 'assets/images/avatar.png');

  static Map<String, AppUser> _users = {
    _defaultUser.email: _defaultUser,
  };
  static AppUser? _currentUser;
  static MultiStreamController<AppUser?>? _userStreamController;

  static final _userStream = Stream<AppUser?>.multi((controller) {
    //this function is executed when the first listener is added to the stream
    _userStreamController = controller;
    //controller.add will send the data to the stream
    //and the stream will send the data to the listeners
    //by the methodo listen()
    _updateUser(_defaultUser);
    //
    //    _currentUser = user;
    //     _userStreamController?.add(_currentUser);
  });

  //this getter will be used to listen to the stream
  Stream<AppUser?> get userChanges {
    return _userStream;
  }

  AppUser? get currentUser {
    return _currentUser;
  }

  Future<void> signup(
    String email,
    String password,
    String username,
    File? image,
  ) async {
    final newUser = AppUser(
      id: Random().nextDouble().toString(),
      name: username,
      email: email,
      imageURL: image?.path ?? 'assets/images/avatar.png',
    );
    //putIfAbsent will add the user to the map if it is not there
    _users.putIfAbsent(email, () => newUser);
    _updateUser(newUser);
  }

  Future<void> login(String email, String password) async {
    _updateUser(_users[email]);
  }

  Future<void> logout() async {
    _updateUser(null);
  }

  static void _updateUser(AppUser? user) {
    _currentUser = user;
    _userStreamController?.add(_currentUser);
  }
}
