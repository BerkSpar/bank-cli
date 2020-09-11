import 'package:bank_cli/models/operation.dart';

abstract class IAccount {
  int id;
  String name;
  double balance;
  List<Operation> operations;
}

class AccountImpl extends IAccount {}
