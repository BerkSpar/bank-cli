import 'package:bank_cli/bank_cli.dart' as cli;

void main(List<String> arguments) {
  if (arguments.isEmpty) {
    cli.login('felipe', '1234');
    return null;
  }

  switch (arguments[0]) {
    case '-h':
    case '--help':
      cli.showHelp();
      break;
    case '-d':
    case '--deposit':
      cli.deposit(arguments[1]);
      break;
    case '-w':
    case '--withdraw':
      cli.withdraw(arguments[1]);
      break;
    case '-i':
    case '--info':
      cli.showInfo();
      break;
    case '-l':
    case '--login':
      _getUserPassword(
          arguments, (user, password) => cli.login(user, password));
      break;
    case '-r':
    case '--register':
      _getUserPassword(
          arguments, (user, password) => cli.register(user, password));
      break;
    default:
      cli.showDefault();
      break;
  }
}

void _getUserPassword(
    List<String> args, Function(String user, String password) function) async {
  String user, password;

  for (var i = 0; i < args.length - 1; i++) {
    if ((args[i] == '-u') || (args[i] == '--user')) {
      user = args[i + 1];
    }

    if ((args[i] == '-p') || (args[i] == '--password')) {
      password = args[i + 1];
    }
  }

  function(user, password);
}
