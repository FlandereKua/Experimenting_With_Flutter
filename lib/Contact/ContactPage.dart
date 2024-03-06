import 'package:HelpingHand/models/acquaintance.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../Home/acquaintance_list.dart';
import '../Services/database.dart';

class ContactPage extends StatefulWidget {
  const ContactPage({super.key});

  @override
  State<ContactPage> createState() => _ContactPageState();
}

class _ContactPageState extends State<ContactPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Acquaintances?>?>.value(
      initialData: null,
      value: DataBaseService(uid: _auth.currentUser!.uid).acquaintances,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(90),
          child: AppBar(
            backgroundColor: const Color(0xFF1B1E69),
            title: Row(
              children: [
                InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset(
                      'assets/return.png',
                      width: 30,
                      height: 30,
                    )),
                const SizedBox(
                  width: 20,
                ),
                const Text(
                  'Add Contact',
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
              ],
            ),
          ),
        ),
        body: Center(
            child: Column(
          children: [
            const AcquaintanceList(),
            Padding(
              padding: const EdgeInsets.fromLTRB(40, 30, 0, 20),
              child: InkWell(
                onTap: () {
                  context.pushReplacementNamed("SubAddContact");
                },
                child: const Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 30,
                      height: 30,
                      child: Icon(
                        Icons.add_circle,
                        color: Color(0xFF1B1E69),
                        size: 40,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      'Add Contact',
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFF1B1E69)),
                    )
                  ],
                ),
              ),
            )
          ],
        )),
      ),
    );
  }
}
