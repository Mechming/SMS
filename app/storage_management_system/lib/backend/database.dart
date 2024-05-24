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




void sebisDBTesting() {
  if (true) {
    Item testing_item = Item(id: 1, title: "Burger", count: 2, goalAmount: 4);
    addItem(testing_item);
    //getStorage();
  }
}
