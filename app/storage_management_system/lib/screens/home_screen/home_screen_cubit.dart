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
