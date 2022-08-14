import 'package:flutter/material.dart';
import 'package:friend_tracker/services/timer.dart';
import 'package:friend_tracker/widgets/person_card.dart';
import 'package:provider/provider.dart';

import '../models/person.dart';

class Listing extends StatefulWidget {
  final String title;
  final List<Person> people;
  const Listing({required this.people, required this.title, Key? key})
      : super(key: key);

  @override
  State<Listing> createState() => _ListingState();
}

class _ListingState extends State<Listing> {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.grey.shade300,
      elevation: 5,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.title,
                  style: TextStyle(
                    color: Colors.blueGrey.shade900,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (widget.people.isNotEmpty)
              Expanded(
                child: StreamProvider<DateTime>.value(
                  initialData: DateTime.now(),
                  value: TimerService().timeStream,
                  child: ListView(
                    children: widget.people
                        .map((person) => PersonCard(person: person))
                        .toList(),
                  ),
                ),
              )
            else
              const Center(child: Text('Much lonely :/')),
          ],
        ),
      ),
    );
  }
}
