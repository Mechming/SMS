import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/backend/database.dart';
import 'package:storage_management_system/screens/home_screen/Items_cubit.dart';
import 'package:storage_management_system/screens/home_screen/home_screen.dart';
import 'package:storage_management_system/screens/home_screen/home_screen_cubit.dart';
import 'package:storage_management_system/screens/setting/setting_screen.dart';
import 'package:storage_management_system/screens/shopping_screen/shopping_cubit.dart';
import 'package:storage_management_system/screens/shopping_screen/shopping_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey:
              'BDUEIljLKDGbTKGGcr1mIWHni6-xnEkomSmPwKYfRcE6HxGrtOPVRlEV5JfSJ6-cQkd6zcY52MuXbJYYsYiUPJE',
          appId: '1:1032262691511:android:9c9bca4dda315d4fd8bb32',
          messagingSenderId: '1032262691511',
          projectId: 'sms-backend-a9c19'));

  //addItem("test Item", 1);
  getStorage();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<NavigationCubit>(
          create: (context) => NavigationCubit(),
        ),
        BlocProvider<ShoppingCubit>(
          create: (context) => ShoppingCubit(),
        ),
        BlocProvider<ModalBottomSheetCubit>(
          create: (context) => ModalBottomSheetCubit(),
        ),
        BlocProvider<ItemsCubit>(
          create: (context) => ItemsCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocBuilder<NavigationCubit, NavigationStates>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: state is HomePageState
                  ? const Text('Home')
                  : state is ShoppingPageState
                      ? const Text('Shopping List')
                      : state is SettingsPageState
                          ? const Text('Settings')
                          : const Text('Home'),
              backgroundColor: Colors.green,
              centerTitle: true,
              actions: [
                state is HomePageState
                    ? IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () {},
                      )
                    : Container(),
              ],
            ),
            body: state is HomePageState
                ? const HomeScreen()
                : state is ShoppingPageState
                    ? ShoppingScreen()
                    : state is SettingsPageState
                        ? const SettingsScreen()
                        : Container(),
            bottomNavigationBar: BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_cart_outlined),
                  label: 'Shopping',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings_outlined),
                  label: 'Settings',
                ),
              ],
              onTap: (index) {
                switch (index) {
                  case 0:
                    BlocProvider.of<NavigationCubit>(context)
                        .onNavigationChanged(
                            NavigationEvents.HomePageClickedEvent);
                    break;
                  case 1:
                    BlocProvider.of<NavigationCubit>(context)
                        .onNavigationChanged(
                            NavigationEvents.ShoppingPageClickedEvent);
                    break;
                  case 2:
                    BlocProvider.of<NavigationCubit>(context)
                        .onNavigationChanged(
                            NavigationEvents.SettingsPageClickedEvent);
                    break;
                }
              },
            ),
          );
        },
      ),
    );
  }
}
