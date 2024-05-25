import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/models/shopping_item.dart';

class ShoppingCubit extends Cubit<List<ShoppingItem>> {
  ShoppingCubit() : super([]);

  void addItem(String itemName) {
    var existingItemIndex = state.indexWhere((item) => item.name == itemName);

    if (existingItemIndex != -1) {
      // The item is already on the list, so increase its quantity.
      state[existingItemIndex].quantity += 1;
      print(state[existingItemIndex].quantity);
    } else {
      // The item is not on the list, so add it.
      state.add(ShoppingItem(name: itemName));
    }

    emit(List.from(state));
    print('shopping cubit state $state');
  }

  void removeItem(int index) {
    state.removeAt(index);
    emit(List.from(state));
  }

  void increaseItemQuantity(int index) {
    state[index].increaseQuantity();
    emit(List.from(state));
  }

  void decreaseItemQuantity(int index) {
    state[index].decreaseQuantity();
    emit(List.from(state));
  }
}
