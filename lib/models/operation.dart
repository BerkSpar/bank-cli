enum OperationType { withdraw, deposit, balance, transfer }

class Operation {
  DateTime time;
  double value;
  OperationType operationType;

  Operation({
    this.time,
    this.value,
    this.operationType,
  });
}
