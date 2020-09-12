import 'package:bank_cli/models/operation.dart';

class Account {
  String _username;
  double _balance = 0;
  List<Operation> _operations;
  DateTime _since;

  String get username => _username;
  double get balance => _balance;
  List<Operation> get operations => _operations;
  DateTime get since => _since;

  set username(String username) => _username = username;

  Account(name) {
    _username = name;
    _operations = <Operation>[];
    _since = DateTime.now();
  }

  Account.login(Map<String, dynamic> data) {
    _username = data['username'];
    _balance = data['balance'];
  }

  bool deposit(double value) {
    if (value <= 0) return false;

    _operations.add(Operation(
      operationType: OperationType.deposit,
      time: DateTime.now(),
      value: value,
    ));

    _balance += value;
    return true;
  }

  bool withdraw(double value) {
    if (value > balance) return false;

    _operations.add(Operation(
      operationType: OperationType.withdraw,
      time: DateTime.now(),
      value: value,
    ));

    _balance -= value;
    return true;
  }

  Map<String, dynamic> register(String password) {
    final data = <String, dynamic>{};
    data['username'] = _username;
    data['balance'] = 0.0;
    data['password'] = password;
    return data;
  }
}
