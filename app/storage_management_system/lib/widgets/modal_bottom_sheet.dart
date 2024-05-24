import 'package:flutter/material.dart';

final TextEditingController controller = TextEditingController();

final Widget addItemBottomSheet = Container(
  padding: EdgeInsets.all(20.0),
  child: Column(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      TextField(
        controller: controller,
        decoration: InputDecoration(labelText: 'Item Name'),
      ),
      SizedBox(height: 20),
      ElevatedButton(
        child: Text('Add Item'),
        onPressed: () {
          // context.read<ShoppingCubit>().addItem(controller.text);
          // Navigator.of(context).pop();
        },
      ),
    ],
  ),
);
