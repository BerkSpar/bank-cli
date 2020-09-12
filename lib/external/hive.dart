import 'dart:async';
import 'dart:io';

import 'package:hive/hive.dart';

import '../models/account.dart';

class BankData {
  Completer<Box> _completer = Completer<Box>();

  BankData() {
    _init();
  }

  Future<void> _init() async {
    Hive.init(Directory.current.path);
    final box = await Hive.openBox('BankData');
    if (!_completer.isCompleted) _completer.complete(box);
  }

  Future<bool> registerAccount(String user, String password) async {
    try {
      final box = await _completer.future;

      await box.put(user, Account(user).register(password));

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Account> loginAccount(String user, String password) async {
    try {
      final box = await _completer.future;

      final result = await box.get(user);

      if (result != null) {
        return Account.login(result);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
