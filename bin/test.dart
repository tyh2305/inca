import 'dart:io';
import 'package:sqflite/sqflite.dart';

void main() {
  print("Hello whats your name: ");
  String? x = stdin.readLineSync();
  print("Hello $x");
}
