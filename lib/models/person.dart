import 'package:hive/hive.dart';
part 'person.g.dart';

@HiveType(typeId: 0)
class Person extends HiveObject {
  Person({required this.name, required this.lastSeen, required this.frequent});
  @HiveField(0)
  late String name;
  @HiveField(1)
  late DateTime lastSeen;
  @HiveField(2)
  late bool frequent;
}
