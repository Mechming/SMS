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

  void addSpecialItem(String itemName, int amount) {
    if (!state.any((item) => item.itemName == itemName)) {
      addItem(ModalBottomSheetState(
        itemName: itemName,
        counter1: amount,
        counter2: 0,
      ));
    }
  }

  void addItemsFromJson(String jsonString) {
    final items = jsonDecode(jsonString) as Map<String, dynamic>;
    for (var entry in items.entries) {
      String name = entry.key;
      int amount = entry.value;
      if (!state.any((existingItem) => existingItem.itemName == name)) {
        addSpecialItem(name, amount);
      } else {
        final existingItem =
            state.firstWhere((element) => element.itemName == name);
        updateItem(state.indexOf(existingItem),
            existingItem.copyWith(counter1: existingItem.counter1 + amount));
      }
    }
  }
}
