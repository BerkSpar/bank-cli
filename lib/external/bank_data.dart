import 'dart:async';
import 'dart:io';

import 'package:bank_cli/models/operation.dart';
import 'package:hive/hive.dart';

import '../models/account.dart';

class BankData {
  final Completer<Box> _completer = Completer<Box>();

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

  Future<bool> loginAccount(String user, String password) async {
    try {
      final box = await _completer.future;

      final result = await box.get(user);

      final account = Account.login(result);
      await box.put('current_user', account.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> save(Operations operations, Account account) async {
    try {
      final box = await _completer.future;

      await box.put('current_user', account.toJson());
      await box.put(account.username, account.toJson());

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<Account> getCurrentUser() async {
    try {
      final box = await _completer.future;

      final current_user = await box.get('current_user');

      if (current_user != null) {
        return Account.login(current_user);
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<bool> logoutAccount() async {
    try {
      final box = await _completer.future;

      await box.put('current_user', null);

      return true;
    } catch (e) {
      return false;
    }
  }
}
