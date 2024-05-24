import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:storage_management_system/models/item.dart';

Future<void> addItem(Item item) async {
  CollectionReference storage = FirebaseFirestore.instance.collection('storage');

  try {
    QuerySnapshot snapshot = await storage.where("id", isEqualTo: item.id).get();
    if (snapshot.size != 0) {
      throw Exception("0x01 Item ID already in storage");
    } else {
      await storage.add({
        'id': item.id,
        'name': item.title,
        'amount': item.count,
        'goal_amount': item.goalAmount,
      });
    }
  } catch (e) {
    print("Failed to add item: $e");
  }
}

Future<void> getStorage() async {
  CollectionReference storage = FirebaseFirestore.instance.collection('storage');
  try {
    QuerySnapshot snapshot = await storage.get();
    snapshot.docs.forEach((doc) {
      print('${doc.id} => ${doc.data()}');
    });
  } catch (error) {
    print("Failed to get storage: $error");
  }
}

Future<void> updateItem(Item item) async {
  FirebaseFirestore db = FirebaseFirestore.instance;
  CollectionReference storage = db.collection('storage');
  try {
    QuerySnapshot querySnapshot = await storage.where('id', isEqualTo: item.id).get();
    if (querySnapshot.docs.isEmpty) {
      throw Exception("0x02 No matching ID found");
    }

    DocumentReference documentRef = querySnapshot.docs.first.reference;

    await db.runTransaction((transaction) async {
      DocumentSnapshot snapshot = await transaction.get(documentRef);

      if (!snapshot.exists) {
        throw Exception("0x03 No matching document found for ID (this is not possible)");
      }

      transaction.update(documentRef, {
        'id': item.id,
        'name': item.title,
        'amount': item.count,
        'goal_amount': item.goalAmount,
      });
    });
  } catch (e) {
    print("Failed to update item: $e");
  }
}

Future<void> deleteItem(Item item) async {
  CollectionReference storage = FirebaseFirestore.instance.collection('storage');

  try {
    QuerySnapshot querySnapshot = await storage.where('id', isEqualTo: item.id).get();
    if (querySnapshot.docs.isEmpty) {
      throw Exception("0x02 No matching ID found");
    }

    DocumentReference documentRef = querySnapshot.docs.first.reference;
    await storage.doc(documentRef.id).delete();
  } catch (e) {
    print("Failed to delete item: $e");
  }
}

void sebisDBTesting() async {
  Item testingItem = Item(id: 25, title: "Burger", count: 2, goalAmount: 4);

  await addItem(testingItem);
  await getStorage();
  await deleteItem(testingItem);
  await getStorage();
}
