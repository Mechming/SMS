import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:storage_management_system/models/item.dart';

Future<void> addItem(Item item) async {
  CollectionReference storage = FirebaseFirestore.instance.collection('storage');

  storage.where("id", isEqualTo: item.id).get().then(
      (snapshot) {
        if (snapshot.size != 0) {
          throw Exception("0x01 Item ID already in storage");
        } else {
          return storage.add({
            'id': item.id,
            'name': item.title,
            'amount': item.count,
            'goal_amount': item.goalAmount,
          });
        }
      }
  );
}

Future<void> getStorage() async {
  CollectionReference storage = FirebaseFirestore.instance.collection('storage');
  return storage.get()
      .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((doc) {
          print('${doc.id} => ${doc.data()}');
        });
  })
      .catchError((error) => print("Failed to get storage: $error"));
}

Future<void> updateItem(Item item) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference storage = FirebaseFirestore.instance.collection('storage');
  QuerySnapshot querySnapshot = await storage
      .where('id', isEqualTo: item.id)
      .get();
  if (querySnapshot.docs.length != 1) {
    throw Exception("0x02 Multiple or no matching ID found");
  }

  DocumentReference documentRef = querySnapshot.docs.first.reference;

  await db.runTransaction((transaction) async {
    DocumentSnapshot snapshot = await transaction.get(documentRef);

    if (!snapshot.exists) {
      throw Exception("0x03 no matching document found for ID (this is not possible)");
    }

    transaction.update(documentRef, {
      'id': item.id,
      'name': item.title,
      'amount': item.count,
      'goal_amount': item.goalAmount,
    });
  });
}


void sebisDBTesting() {
  if (true) {
    Item testing_item = Item(id: 10, title: "Burger", count: 2, goalAmount: 4);
    addItem(testing_item);
    getStorage();
    testing_item.title = "Hambuger";
    updateItem(testing_item);
    getStorage();
  }
}
