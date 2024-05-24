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
                leading: CircleAvatar(
                  child: Text('${index + 1}'),
                ),
                title: Text(items[index].itemName),
                subtitle: Text(
                    'Counter 1: ${items[index].counter1}, Counter 2: ${items[index].counter2}'),
                onTap: () {}),
          );
        },
      );
    },
  );
}
