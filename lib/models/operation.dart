enum OperationType { withdraw, deposit, balance, transfer }

class Operation {
  DateTime date;
  double value;
  OperationType operationType;

  Operation({
    this.date,
    this.value,
    this.operationType,
  });

  Operation.fromJson(Map json) {
    date = json['date'];
    value = json['value'];
    operationType = OperationType.values[json['operation']];
  }

  Map toJson() {
    final data = {};
    data['date'] = date;
    data['value'] = value;
    data['operation'] = operationType.index;
    return data;
  }
}

class Operations {
  List<Operation> operations = <Operation>[];

  Operations() {
    operations = <Operation>[];
  }

  Operations.fromJson(Map json) {
    if (json['operations'] != null) {
      operations = <Operation>[];
      json['operations'].forEach((v) {
        operations.add(Operation.fromJson(v));
      });
    }
  }

  Map toJson() {
    final data = {};
    if (operations != null) {
      data['operations'] = operations.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
