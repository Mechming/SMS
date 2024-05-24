import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:storage_management_system/models/item.dart';

Future<void> addItem(Item item) async {
  CollectionReference storage = FirebaseFirestore.instance.collection('storage');
  final query = storage.where("id", isEqualTo: item.id);
  print(query)

  return storage.add({
    'name': "hello",
    'amount': 1,
  })
      .then((value) => print("Added item succesfully"))
      .catchError((error) => print("Item not added: $error"));
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
    //addItem("test Item", 1);
    getStorage();
  }
}
