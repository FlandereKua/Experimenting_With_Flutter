import 'package:HelpingHand/models/acquaintance.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataBaseService {
  final String uid;
  late String acqUid = '';
  DataBaseService({required this.uid});
  final CollectionReference userDataCollection =
      FirebaseFirestore.instance.collection('Users');
  final CollectionReference acquaintancesDataCollection =
      FirebaseFirestore.instance.collection('Acquaintances');

  Future setUserData(String phoneNumber, String name) async {
    return await userDataCollection
        .doc(uid)
        .set({'Full Name': name, 'Phone Number': phoneNumber, 'Address': ''});
  }

  Future updateUserData(String phoneNumber, String name, String address) async {
    return await userDataCollection.doc(uid).set(
        {'Full Name': name, 'Phone Number': phoneNumber, 'Address': address});
  }

  Future updateAcquaintances(
      String phoneNumber, String name) async {
    return await acquaintancesDataCollection.doc().set(
        {'Full Name': name, 'Phone Number': phoneNumber, 'User uid': uid});
  }
  List<Acquaintances?> _acquaintanceListFromSnapShot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) {
      return doc.get('User uid') == uid ? Acquaintances(
        name: doc.get('Full Name') ?? "",
        phoneNumber: doc.get('Phone Number') ?? "",
        userUid: doc.get('User uid') ?? "",
      ) : null;
    }).toList();
  }
  Stream<List<Acquaintances?>> get acquaintances {
      return acquaintancesDataCollection.snapshots().map(_acquaintanceListFromSnapShot);
  }
}
