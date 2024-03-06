import 'package:flutter/material.dart';
import 'package:HelpingHand/models/acquaintance.dart';
class AcquaintanceTile extends StatelessWidget {
  final Acquaintances? acquaintances;
  const AcquaintanceTile({super.key, required this.acquaintances});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: const EdgeInsets.fromLTRB(20.00, 6.00, 20.00, 0.00),
        child: ListTile(
          leading: const CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.blueAccent,
          ),
          title: Text(acquaintances!.name.toString()),
          subtitle: Text('Phone Number: ${acquaintances!.phoneNumber.toString()}'),
        ),
      ),
    );
  }
}
