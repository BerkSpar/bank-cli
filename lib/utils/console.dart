import 'dart:io';

void drawProgressBar(double amount, int size, {String text}) {
  final limit = (size * amount).toInt();
  stdout.write(
    '\r\x1b[38;5;75;51m' +
        String.fromCharCodes(List.generate(size, (int index) {
          if (index < limit) {
            return 0x2593;
          }
          return 0x2591;
        })) +
        '\x1b[0m',
  );
}

dynamic terminal({String windows, String linux}) {
  if (Platform.isWindows) {
    return Process.runSync(windows, [], runInShell: true).stdout;
  } else {
    return Process.runSync(linux, [], runInShell: true).stdout;
  }
}
