import 'package:flutter/material.dart';

import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  User? _user;
  String? _password;

  User get user => _user!;
  String get password => _password!;

  void setUser(User user) {
    _user = user;
  }

  void updateUser(User user) {
    _user = user;
    notifyListeners();
  }

  void updatePassword(String? newPassword) {
    _password = newPassword;
    notifyListeners();
  }

  List<User> _users = [];

  List<User> get users => _users;

  void setUsers(List<User> users) {
    _users = users;
  }

  void updateUsers(User updatedUser) {
    int index = _users.indexWhere((user) => user.id == updatedUser.id);
    if (index != -1) {
      _users[index] = updatedUser;
      notifyListeners();
    }
  }

  void deleteUser(String deletedUserId) {
    _users.removeWhere((user) => user.id == deletedUserId);
    notifyListeners();
  }
}
