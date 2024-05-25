import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/models/shopping_item.dart';
import 'package:storage_management_system/screens/shopping_screen/shopping_cubit.dart';
import 'package:storage_management_system/widgets/modal_bottom_sheet.dart';

class ShoppingScreen extends StatelessWidget {
  const ShoppingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => showModalBottomSheet(
          context: context,
          builder: (ctx) => Container(
            height: 600,
            child: const AddItemBottomSheet(),
          ),
        ),
        label: const Text('Add Item'),
        icon: const Icon(Icons.add),
      ),
      body: BlocBuilder<ShoppingCubit, List<ShoppingItem>>(
        builder: (context, shoppingList) {
          print('Shopping List: $shoppingList');
          return GridView.builder(
            padding: const EdgeInsets.all(10.0),
            itemCount: shoppingList.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 3 / 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemBuilder: (ctx, i) => GestureDetector(
              onTap: () {
                context.read<ShoppingCubit>().removeItem(i);
              },
              child: Card(
                elevation: 4,
                child: SizedBox(
                  height: 100,
                  child: Padding(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Center(
                            child: Text(
                              shoppingList[i].name,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Quantity:',
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<ShoppingCubit>()
                                        .decreaseItemQuantity(i);
                                  },
                                  icon: Icon(Icons.remove),
                                ),
                                Text('${shoppingList[i].quantity}'),
                                IconButton(
                                  onPressed: () {
                                    context
                                        .read<ShoppingCubit>()
                                        .increaseItemQuantity(i);
                                  },
                                  icon: Icon(Icons.add),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
