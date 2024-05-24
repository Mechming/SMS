import 'package:flutter/material.dart';
import 'package:storage_management_system/widgets/modal_bottom_sheet.dart';

class ShoppingScreen extends StatelessWidget {
  final List<String> shoppingList = [
    'Apples',
    'Bananas',
    'Oranges',
    'Grapes',
    'Bread',
    'Milk',
    'Eggs',
    'Cheese',
    // Add more items here
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (ctx) => addItemBottomSheet,
        ),
        label: const Text('Add Item'),
        icon: const Icon(Icons.add),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(10.0),
        itemCount: shoppingList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (ctx, i) => Card(
          elevation: 4,
          child: SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      shoppingList[i],
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  SizedBox(height: 10),
                  Expanded(
                    child: Text(
                      'Quantity: 1',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
