import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> addItem(String name, int amount) {
  CollectionReference storage = FirebaseFirestore.instance.collection('storage');
  return storage.add({
    'name': name,
    'amount': amount,
  })
      .then((value) => print("Added item succesfully"))
      .catchError((error) => print("Item not added: $error"));
}

Future<void> getStorage() {
  CollectionReference storage = FirebaseFirestore.instance.collection('storage');
  return storage.get()
      .then((QuerySnapshot snapshot) {
        snapshot.docs.forEach((doc) {
          print('${doc.id} => ${doc.data()}');
        });
  })
      .catchError((error) => print("Failed to get storage: $error"));
}