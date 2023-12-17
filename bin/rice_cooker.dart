import 'dart:io';
import 'package:rice_cooker/rice_cooker.dart';
void main() {
  RiceCooker riceCooker = RiceCooker();

  while (true) {
    riceCooker.displayOptions();
    print("Choose a command : ");
    int option = int.parse(stdin.readLineSync()!);
    riceCooker.executeOption(option);
  }
}
