import 'package:sqflite/sqflite.dart';

abstract class Migration {
  int get version;
  String get name;

  Future<void> up(Database db);
}
