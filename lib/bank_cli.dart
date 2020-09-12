import 'dart:io';
import 'package:bank_cli/utils/console.dart';
import 'external/hive.dart';
import 'external/hive.dart';
import 'models/account.dart';
import 'package:intl/intl.dart';

import 'models/account.dart';

void showHelp() {
  final text = '''
-h                                     Show all commands.
--help 

-d [double value]                      Deposit a specific value above zero
--deposit [double value]               in the main account.

-w [double value]                      Withdraw a specific value bigger than 
--withdraw [double value]              account's balance.

-i                                     See main account info.
--info

-l [-u --user | -p --password]         Log in and set main user. Needs a user
--login [-u --user | -p --password]    and a password.

-r [-u --user | -p --password]         Register a new account. Needs a user and
--register [-u --user | -p --password] a password. 
''';

  print(text);
}

void showDefault() {
  print('It\'s nothing a command, type -h to help.');
}

void showInfo() {
  final account = _getMainAccount();

  final info = '''
------- Account -------
Username: ${account.username}
Balance: R\$ ${account.balance.toStringAsFixed(2).replaceAll('.', ',')}

Member since ${DateFormat('dd/MM/yyyy').format(account.since)}
-----------------------
''';

  print(info);
}

void deposit(String value) {
  final account = _getMainAccount();

  try {
    final parsedValue = double.parse(value);
    final realValue =
        'R\$ ${parsedValue.toStringAsFixed(2).replaceAll('.', ',')}';

    if (account.deposit(parsedValue)) {
      print('Deposited R\$ $realValue in ${account.username}\'s account.');
    } else {
      print('Cannot deposit $realValue.');
    }
  } catch (e) {
    print('There is something wrong.');
  }
}

void withdraw(String value) {
  final account = _getMainAccount();

  try {
    final parsedValue = double.parse(value);
    final realValue =
        'R\$ ${parsedValue.toStringAsFixed(2).replaceAll('.', ',')}';

    if (account.withdraw(parsedValue)) {
      print('Withdrawn R\$ $realValue in ${account.username}\'s account.');
    } else {
      print('Cannot withdraw $realValue.');
    }
  } catch (e) {
    print('There is something wrong.');
  }
}

void register(String user, String password) {
  final bankData = BankData();
  bankData.registerAccount(user, password);
}

void login(String user, String password) {
  // final bankData = BankData();
  // bankData.loginAccount(user, password);
  // terminal(windows: 'SET bank_account=$user');
  // print(terminal(windows: 'ECHO %bank_account%'));
}

Account _getMainAccount() {
  // final String result = terminal(windows: 'ECHO %bank_account%');
  // if (result.substring(0, 14) == '%bank_account%') {
  //   print('You need login to use this option.');
  //   exit(2);
  // } else {
  //   return Account('Felipe');
  // }
  return Account('felipe');
}
