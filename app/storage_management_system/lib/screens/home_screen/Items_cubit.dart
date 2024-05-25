import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/screens/home_screen/home_screen_cubit.dart';

class ItemsCubit extends Cubit<List<ModalBottomSheetState>> {
  ItemsCubit() : super([]);

  void addItem(ModalBottomSheetState item) {
    List<ModalBottomSheetState> updatedList = List.from(state);
    updatedList.add(item);
    emit(updatedList);
  }

  bool updateItem(int index, ModalBottomSheetState updatedItem) {
    final items = List<ModalBottomSheetState>.from(state);
    if (updatedItem.counter2 == 0) {
      items.removeAt(index);
    } else {
      items[index] = updatedItem;
    }
    emit(items);

    return updatedItem.counter1 <= updatedItem.counter2;
  }

  void addItemsFromJson(String jsonString) {
    final items = jsonDecode(jsonString) as Map<String, dynamic>;
    for (var entry in items.entries) {
      String name = entry.key;
      int amount = entry.value;

      final existingItemIndex =
          state.indexWhere((item) => item.itemName == name);

      if (existingItemIndex == -1) {
        // If the item doesn't exist, add a new item with a blue card
        addItem(ModalBottomSheetState(
          itemName: name,
          counter2: amount,
          counter1: 0,
        ));
      } else {
        // If the item exists, update the counter2 of the existing item
        final existingItem = state[existingItemIndex];
        updateItem(existingItemIndex,
            existingItem.copyWith(counter2: existingItem.counter2 + amount));
      }
    }
  }
}
