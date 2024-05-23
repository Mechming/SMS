import 'package:flutter/material.dart';

Widget modernListView() {
  return ListView.builder(
    itemCount: 10,
    itemBuilder: (context, index) {
      return Card(
        elevation: 5,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: ListTile(
          leading: CircleAvatar(
            child: Text('${index + 1}'),
          ),
          title: Text('Item ${index + 1}'),
          subtitle: Text('This is the description of item ${index + 1}'),
          onTap: () {
            // Handle your item tap here
          },
        ),
      );
    },
  );
}
