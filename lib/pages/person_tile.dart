import 'package:flutter/material.dart';
import 'package:carz/Objects/person_entry.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class PersonTile extends StatelessWidget {
  PersonEntry person;
  late Color tileColor;
  Function(BuildContext)? deletePersonFunction;
  Function(BuildContext)? callPersonFunction;
  Function(BuildContext)? whatsappPersonFunction;
  PersonTile({
    super.key,
    required this.person,
    required this.deletePersonFunction,
    required this.callPersonFunction,
    required this.whatsappPersonFunction,
  }) {
    if (this.person.type == "Buyer") {
      this.tileColor = Colors.greenAccent;
    } else if (this.person.type == "Seller") {
      this.tileColor = Color.fromARGB(255, 246, 246, 126);
    } else {
      this.tileColor = Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 25.0,
        right: 25.0,
        top: 25.0,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: callPersonFunction,
              icon: Icons.call_rounded,
              backgroundColor: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            SlidableAction(
              onPressed: whatsappPersonFunction,
              icon: Icons.whatsapp_rounded,
              backgroundColor: Colors.green.shade200,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: deletePersonFunction,
              icon: Icons.delete_rounded,
              backgroundColor: Colors.red.shade200,
              borderRadius: BorderRadius.circular(12),
            )
          ],
        ),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(person.name),
              Text(person.number),
              Text(person.budget),
              Text(person.carModel),
            ],
          ),
          decoration: BoxDecoration(
            color: tileColor,
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ),
    );
  }
}
