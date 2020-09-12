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

    account.deposit(parsedValue);

    print(
        'Deposited R\$ ${parsedValue.toStringAsFixed(2).replaceAll('.', ',')} in ${account.name}\'s account');
  } catch (e) {
    print('There is something wrong');
  }
}

Account _getMainAccount() {
  return Account('Felipe');
}
