import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:friend_tracker/services/db.dart';
import 'package:intl/intl.dart';

class AddPerson extends StatefulWidget {
  const AddPerson({Key? key}) : super(key: key);

  @override
  State<AddPerson> createState() => _AddPersonState();
}

class _AddPersonState extends State<AddPerson> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _lastSeen = TextEditingController();
  DateTime _lastSeenDate = DateTime.now();
  final DateFormat _format = DateFormat('dd/MM/yyyy');
  bool _frequent = false;

  @override
  void dispose() {
    _name.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _lastSeen.text = _format.format(_lastSeenDate);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final db = DatabaseService();
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Friend',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey.shade800,
            ),
          ),
          const SizedBox(height: 20),
          TextField(
            controller: _name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Name',
              labelText: 'Name',
            ),
          ),
          const SizedBox(height: 20),
          TextField(
              controller: _lastSeen,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Last Seen',
                labelText: 'Last Seen',
              ),
              readOnly: true,
              onTap: () async {
                DateTime? newLastSeen = await showDatePicker(
                  context: context,
                  initialDate: _lastSeenDate,
                  firstDate: DateTime(0),
                  lastDate: DateTime.now(),
                );
                if (newLastSeen != null) {
                  _lastSeenDate = newLastSeen;
                  setState(() {
                    _lastSeen.text = _format.format(_lastSeenDate);
                  });
                }
              }),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Is this someone you see frequently?'),
              Switch(
                value: _frequent,
                onChanged: (state) {
                  setState(() {
                    _frequent = state;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            style: ButtonStyle(
              minimumSize: MaterialStateProperty.all(
                const Size.fromHeight(40),
              ),
            ),
            onPressed: () {
              db.addPerson(_name.text, _lastSeenDate, _frequent);
              Navigator.pop(context);
            },
            child: const Text('Submit'),
          ),
        ],
      ),
    );
  }
}
