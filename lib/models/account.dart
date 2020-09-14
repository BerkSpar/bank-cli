import 'package:bank_cli/external/bank_data.dart';
import 'package:bank_cli/models/operation.dart';

class Account {
  String _username;
  double _balance = 0;
  Operations _operations = Operations();

  String get username => _username;
  double get balance => _balance;
  Operations get operations => _operations;

  set username(String username) => _username = username;

  Account(name) {
    _username = name;
    _operations = Operations();
  }

  Account.login(Map data) {
    _username = data['username'];
    _balance = data['balance'];

    try {
      _operations = Operations.fromJson(data['operations']);
    } catch (e) {
      _operations = Operations();
    }
  }

  bool deposit(double value) {
    if (value <= 0) return false;

    try {
      _balance += value;

      addOperation(Operation(
        date: DateTime.now(),
        operationType: OperationType.withdraw,
        value: value,
      ));

      return true;
    } catch (e) {
      return false;
    }
  }

  bool withdraw(double value) {
    if (value > balance) return false;

    try {
      _balance -= value;

      addOperation(Operation(
        date: DateTime.now(),
        operationType: OperationType.withdraw,
        value: value,
      ));

      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addOperation(Operation operation) async {
    try {
      final bankData = BankData();

      operations.operations.add(operation);

      return await bankData.save(operations, this);
    } catch (e) {
      return false;
    }
  }

  Map register(String password) {
    final data = {};
    data['username'] = _username;
    data['balance'] = 0.0;
    data['password'] = password;
    data['operations'] = _operations.toJson();
    return data;
  }

  Map toJson() {
    final data = {};
    data['username'] = _username;
    data['balance'] = balance;
    data['operations'] = _operations.toJson();
    return data;
  }
}
