import 'package:HelpingHand/models/acquaintance.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Contact/AcquaintanceTile.dart';

class AcquaintanceList extends StatefulWidget {
  const AcquaintanceList({super.key});

  @override
  State<AcquaintanceList> createState() => _AcquaintanceListState();
}

class _AcquaintanceListState extends State<AcquaintanceList> {
  @override
  Widget build(BuildContext context) {
    final acquaintances = Provider.of<List<Acquaintances?>?>(context) ?? [];

    return ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: acquaintances.length,
        itemBuilder: (context, index) {
          return AcquaintanceTile(acquaintances: acquaintances[index]);
        });
  }
}
