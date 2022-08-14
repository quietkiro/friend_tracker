import 'package:flutter/material.dart';
import 'package:friend_tracker/services/timer.dart';
import 'package:provider/provider.dart';

import '../models/person.dart';

import '../services/db.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({required this.person, Key? key}) : super(key: key);

  final Person person;

  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    final now = Provider.of<DateTime>(context);
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: ExpansionTile(
          controlAffinity: ListTileControlAffinity.leading,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(person.name),
              Text(smartDiff(now: now, old: person.lastSeen)),
            ],
          ),
          children: [
            Row(
              children: [
                // View
                Expanded(
                  child: InkWell(
                    onTap: () {
                      db.sawPerson(person.name);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                            BorderRadius.only(bottomLeft: Radius.circular(20)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.remove_red_eye, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // Frequent
                Expanded(
                  child: InkWell(
                    onTap: () {
                      db.switchFreq(person.name);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.green,
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.repeat, color: Colors.white),
                      ),
                    ),
                  ),
                ),
                // Delete
                Expanded(
                  child: InkWell(
                    onTap: () {
                      db.deletePerson(person.name);
                    },
                    child: Container(
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        borderRadius:
                            BorderRadius.only(bottomRight: Radius.circular(20)),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Icon(Icons.delete, color: Colors.white),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
