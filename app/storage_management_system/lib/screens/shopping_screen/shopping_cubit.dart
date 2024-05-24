import 'package:flutter_bloc/flutter_bloc.dart';

class ShoppingCubit extends Cubit<List<String>> {
  ShoppingCubit() : super([]);

  void addItem(String item) {
    state.add(item);
    emit(List.from(state));
  }
}
