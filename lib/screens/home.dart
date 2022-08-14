import 'package:flutter/material.dart';
import 'package:friend_tracker/models/person.dart';
import 'package:friend_tracker/screens/add_person.dart';
import 'package:friend_tracker/services/db.dart';
import 'package:friend_tracker/widgets/listing.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const AddPerson();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
      endDrawer: Drawer(
        width: MediaQuery.of(context).size.width / 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_forever),
              title: const Text('Delete All'),
              onTap: () {
                db.deleteAll();
              },
            ),
            ListTile(
              leading: const Icon(Icons.info),
              title: const Text('Credits'),
              onTap: () {
                showLicensePage(context: context);
              },
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: const Text("Friend Tracker"),
        actions: [
          Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openEndDrawer(),
              icon: const Icon(Icons.settings),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ValueListenableBuilder<Box<Person>>(
          valueListenable: db.getListenable(),
          builder: (context, box, child) {
            List<Person> people = box.values.toList();
            return Column(
              children: [
                // Frequents
                Expanded(
                  flex: 2,
                  child: Listing(
                    title: 'Frequents',
                    people: people.where((person) => person.frequent).toList(),
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Listing(
                    title: 'Friends',
                    people: people.where((person) => !person.frequent).toList(),
                  ),
                ),
                // Remaining
              ],
            );
          },
        ),
      ),
    );
  }
}
