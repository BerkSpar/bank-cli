import 'package:bank_cli/bank_cli.dart' as cli;

void main(List<String> arguments) {
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
    default:
      cli.showDefault();
      break;
  }
}
