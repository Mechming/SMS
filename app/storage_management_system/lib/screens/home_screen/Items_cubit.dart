import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/screens/home_screen/home_screen_cubit.dart';

class ItemsCubit extends Cubit<List<ModalBottomSheetState>> {
  ItemsCubit() : super([]);

  void addItem(ModalBottomSheetState item) {
    List<ModalBottomSheetState> updatedList = List.from(state);
    updatedList.add(item);
    emit(updatedList);
  }

  void updateItem(int index, ModalBottomSheetState updatedItem) {
    final items = List<ModalBottomSheetState>.from(state);
    items[index] = updatedItem;
    emit(items);
  }
}
