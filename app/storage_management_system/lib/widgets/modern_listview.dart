import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/screens/home_screen/Items_cubit.dart';
import 'package:storage_management_system/screens/home_screen/home_screen_cubit.dart';
import 'package:storage_management_system/screens/shopping_screen/shopping_cubit.dart';

Widget modernListView() {
  return BlocBuilder<ItemsCubit, List<ModalBottomSheetState>>(
    builder: (context, items) {
      return ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            if (items[index].counter1 == 0) {
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: Colors.blue,
                child: ListTile(
                  minTileHeight: 100,
                  title: Center(
                    child: Text(
                      items[index].itemName,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500),
                    ),
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text('available: '),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (items[index].counter2 > 0) {
                            context.read<ItemsCubit>().updateItem(
                                index,
                                items[index].copyWith(
                                    counter2: items[index].counter2 - 1));
                          }
                        },
                      ),
                      Text('${items[index].counter2}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          context.read<ItemsCubit>().updateItem(
                              index,
                              items[index].copyWith(
                                  counter2: items[index].counter2 + 1));
                        },
                      ),
                    ],
                  ),
                ),
              );
            } else {
              return Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                color: items[index].counter1 < items[index].counter2
                    ? Colors.lightGreenAccent
                    : items[index].counter2 == items[index].counter1
                        ? Colors.orange
                        : Colors.red,
                child: ListTile(
                  minTileHeight: 100,
                  title: Column(
                    children: [
                      Center(
                          child: Text(
                        items[index].itemName,
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w500),
                      )),
                      const SizedBox(
                        height: 5,
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Target Value: ',
                        style: TextStyle(fontSize: 12),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (items[index].counter1 > 0) {
                            context.read<ItemsCubit>().updateItem(
                                index,
                                items[index].copyWith(
                                    counter1: items[index].counter1 - 1));
                          }
                        },
                      ),
                      Text('${items[index].counter1}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          context.read<ItemsCubit>().updateItem(
                              index,
                              items[index].copyWith(
                                  counter1: items[index].counter1 + 1));
                        },
                      ),
                      const Text(
                        'available: ',
                        style: TextStyle(fontSize: 12),
                      ),
                      IconButton(
                        icon: const Icon(Icons.remove),
                        onPressed: () {
                          if (items[index].counter2 > 0) {
                            bool shouldAdd = context
                                .read<ItemsCubit>()
                                .updateItem(
                                    index,
                                    items[index].copyWith(
                                        counter2: items[index].counter2 - 1));

                            shouldAdd
                                ? context
                                    .read<ShoppingCubit>()
                                    .addItem(items[index].itemName)
                                : null;
                          }
                        },
                      ),
                      Text('${items[index].counter2}'),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: () {
                          context.read<ItemsCubit>().updateItem(
                              index,
                              items[index].copyWith(
                                  counter2: items[index].counter2 + 1));
                        },
                      ),
                    ],
                  ),
                ),
              );
            }
          });
    },
  );
}
