import 'package:cloud_firestore/cloud_firestore.dart';

import 'models/lams.dart';

class DatabaseService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Stream<List<Lams>> getLams() {
    var lol;
    lol = _db
        .collection(
          'lams',
        )
        .withConverter<Lams>(
            fromFirestore: (snapshot, _) =>
                Lams.fromFirestore(snapshot.data()!),
            toFirestore: (snap, _) => snap.toJson())
        .snapshots()
        .map((snapshot) => snapshot.docs.map((e) => e.data()).toList());

    return lol;
  }
}
