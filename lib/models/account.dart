import 'package:bank_cli/models/operation.dart';

class Account {
  String _username;
  double _balance = 0;
  List<Operation> _operations;

  String get username => _username;
  double get balance => _balance;
  List<Operation> get operations => _operations;

  set username(String username) => _username = username;

  Account(name) {
    _username = name;
    _operations = <Operation>[];
  }

  Account.login(Map data) {
    _username = data['username'];
    _balance = data['balance'];
    //get operations
  }

  bool deposit(double value) {
    if (value <= 0) return false;

    //register operation

    _balance += value;
    return true;
  }

  bool withdraw(double value) {
    if (value > balance) return false;

    //register operation

    _balance -= value;
    return true;
  }

  Map register(String password) {
    final data = {};
    data['username'] = _username;
    data['balance'] = 0.0;
    data['password'] = password;
    //save operations
    return data;
  }
}
