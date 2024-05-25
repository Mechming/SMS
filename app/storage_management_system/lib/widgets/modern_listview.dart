import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/screens/home_screen/Items_cubit.dart';
import 'package:storage_management_system/screens/home_screen/home_screen_cubit.dart';

Widget modernListView() {
  return BlocBuilder<ItemsCubit, List<ModalBottomSheetState>>(
    builder: (context, items) {
      return ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
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
                  const Text('Target Value: '),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (items[index].counter1 > 0) {
                        context.read<ItemsCubit>().updateItem(
                            index,
                            items[index]
                                .copyWith(counter1: items[index].counter1 - 1));
                      }
                    },
                  ),
                  Text('${items[index].counter1}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      context.read<ItemsCubit>().updateItem(
                          index,
                          items[index]
                              .copyWith(counter1: items[index].counter1 + 1));
                    },
                  ),
                  const Text('available: '),
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () {
                      if (items[index].counter2 > 0) {
                        context.read<ItemsCubit>().updateItem(
                            index,
                            items[index]
                                .copyWith(counter2: items[index].counter2 - 1));
                      }
                    },
                  ),
                  Text('${items[index].counter2}'),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () {
                      context.read<ItemsCubit>().updateItem(
                          index,
                          items[index]
                              .copyWith(counter2: items[index].counter2 + 1));
                    },
                  ),
                ],
              ),
            ),
          );
        },
      );
    },
  );
}
