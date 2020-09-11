enum OperationType { withdraw, deposit, balance, transfer }

class Operation {
  int id;
  DateTime time;
  double value;
  OperationType operationType;
}
