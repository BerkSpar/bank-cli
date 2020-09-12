import 'package:bank_cli/models/operation.dart';

class Account {
  String _name;
  double _balance = 0;
  List<Operation> _operations;

  String get name => _name;
  double get balance => _balance;
  List<Operation> get operations => _operations;

  set name(String name) => _name = name;

  Account(name) {
    _name = name;
    _operations = <Operation>[];
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
}
