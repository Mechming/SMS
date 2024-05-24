import 'package:flutter_bloc/flutter_bloc.dart';

enum NavigationEvents {
  HomePageClickedEvent,
  ShoppingPageClickedEvent,
  SettingsPageClickedEvent,
}

abstract class NavigationStates {}

class HomePageState extends NavigationStates {}

class ShoppingPageState extends NavigationStates {}

class SettingsPageState extends NavigationStates {}

class NavigationCubit extends Cubit<NavigationStates> {
  NavigationCubit() : super(HomePageState());

  void onNavigationChanged(NavigationEvents navigationEvents) {
    switch (navigationEvents) {
      case NavigationEvents.HomePageClickedEvent:
        emit(HomePageState());
        break;
      case NavigationEvents.ShoppingPageClickedEvent:
        emit(ShoppingPageState());
        break;
      case NavigationEvents.SettingsPageClickedEvent:
        emit(SettingsPageState());
        break;
    }
  }
}

class CounterCubit1 extends Cubit<int> {
  CounterCubit1(super.initialState);

  void setCount(int count) {
    emit(count);
  }
}

class CounterCubit2 extends Cubit<int> {
  CounterCubit2(super.initialState);

  void setCount(int count) {
    emit(count);
  }
}

class ModalBottomSheetState {
  final String itemName;
  final int counter1;
  final int counter2;

  ModalBottomSheetState(
      {required this.itemName, required this.counter1, required this.counter2});
}

class ModalBottomSheetCubit extends Cubit<ModalBottomSheetState> {
  ModalBottomSheetCubit()
      : super(ModalBottomSheetState(itemName: '', counter1: 0, counter2: 0));

  void setModalBottomSheetState(String itemName, int counter1, int counter2) {
    emit(ModalBottomSheetState(
        itemName: itemName, counter1: counter1, counter2: counter2));
  }
}

class TextFieldCubit extends Cubit<String> {
  TextFieldCubit() : super('');

  void setText(String text) {
    emit(text);
  }
}
