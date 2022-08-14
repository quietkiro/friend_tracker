import 'package:flutter/foundation.dart';
import 'package:friend_tracker/models/person.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DatabaseService {
  final people = Hive.box<Person>('people');

  bool addPerson(String name, DateTime lastSeen, bool frequent) {
    if (!getPeople().map((element) => element.name).contains(name)) {
      people.put(
        name,
        Person(
          name: name,
          lastSeen: lastSeen,
          frequent: frequent,
        ),
      );
      return true;
    }
    return false;
  }

  void deletePerson(String name) {
    people.delete(name);
  }

  void deleteAll() {
    for (var element in people.values) {
      people.delete(element.name);
    }
  }

  void sawPerson(String name) {
    var person = people.get(name)!;
    person.lastSeen = DateTime.now();
    people.put(name, person);
  }

  void switchFreq(String name) {
    var person = people.get(name)!;
    person.frequent = !person.frequent;
    people.put(name, person);
  }

  List<Person> getPeople() {
    return people.values.toList().cast<Person>();
  }

  ValueListenable<Box<Person>> getListenable() {
    return people.listenable();
  }
}
