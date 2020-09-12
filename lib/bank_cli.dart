import 'models/account.dart';

void showHelp() {
  final text = '''
-h                        Show all commands
--help 

-d [double value]         Deposit a specific value above zero
--deposit [double value]  in the main account

-w [double value]         Withdraw a specific value bigger than 
--withdraw [double value] account's balance
''';

  print(text);
}

void showDefault() {
  print('It\'s nothing a command, type -h to help');
}

void deposit(String value) {
  final account = _getMainAccount();

  try {
    final parsedValue = double.parse(value);
    final realValue =
        'R\$ ${parsedValue.toStringAsFixed(2).replaceAll('.', ',')}';

    if (account.deposit(parsedValue)) {
      print('Deposited R\$ $realValue in ${account.name}\'s account');
    } else {
      print('Cannot deposit $realValue');
    }
  } catch (e) {
    print('There is something wrong');
  }
}

void withdraw(String value) {
  final account = _getMainAccount();

  try {
    final parsedValue = double.parse(value);
    final realValue =
        'R\$ ${parsedValue.toStringAsFixed(2).replaceAll('.', ',')}';

    if (account.withdraw(parsedValue)) {
      print('Withdrawn R\$ $realValue in ${account.name}\'s account');
    } else {
      print('Cannot withdraw $realValue');
    }
  } catch (e) {
    print('There is something wrong');
  }
}

Account _getMainAccount() {
  return Account('Felipe');
}
