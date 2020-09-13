import 'dart:io';
import 'package:bank_cli/utils/console.dart';
import 'external/bank_data.dart';
import 'external/bank_data.dart';
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

-e                                     Logout the main account. 
--exit-account
''';

  print(text);
}

void showDefault() {
  print('It\'s nothing a command, type -h to help.');
}

void logout() async {
  final bankData = BankData();

  final result = await bankData.logoutAccount();

  if (result) {
    print('All users disconnected.');
  } else {
    print('There is something wrong.');
  }
}

void showInfo() async {
  final account = await _getMainAccount();

  final info = '''
------- Account -------
Username: ${account.username}
Balance: R\$ ${account.balance.toStringAsFixed(2).replaceAll('.', ',')}
-----------------------
''';

  print(info);
}

void deposit(String value) async {
  final account = await _getMainAccount();

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

void withdraw(String value) async {
  final account = await _getMainAccount();

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

void register(String user, String password) async {
  final bankData = BankData();
  if (await bankData.registerAccount(user, password)) {
    print('$user registered, please login to user your account.');
  } else {
    print('Cannot register $user.');
  }
}

void login(String user, String password) async {
  final bankData = BankData();
  final result = await bankData.loginAccount(user, password);

  if (result) {
    print('$user, you are logged now.');
  } else {
    print('$user, you aren\'t logged now');
  }
}

Future<Account> _getMainAccount() async {
  final bankData = BankData();

  final user = await bankData.getCurrentUser();

  if (user != null) {
    return user;
  } else {
    print('You need to make a login.');

    exit(0);
    return null;
  }
}
