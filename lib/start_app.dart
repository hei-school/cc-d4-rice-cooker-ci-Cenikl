import 'rice_cooker.dart';
import 'dart:io';
void main() {
  RiceCooker riceCooker = RiceCooker();

  while (true) {
    riceCooker.displayOptions();
    print("Choose a command : ");
    int option = int.parse(stdin.readLineSync()!);
    riceCooker.executeOption(option);
  }
}