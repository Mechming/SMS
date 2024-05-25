import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/screens/home_screen/Items_cubit.dart';
import 'package:storage_management_system/screens/home_screen/home_screen.dart';
import 'package:storage_management_system/screens/home_screen/home_screen_cubit.dart';
import 'package:storage_management_system/screens/setting/camera_cubit.dart';
import 'package:storage_management_system/screens/setting/setting_screen.dart';
import 'package:storage_management_system/screens/shopping_screen/shopping_cubit.dart';
import 'package:storage_management_system/screens/shopping_screen/shopping_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cameras = await availableCameras();
  final firstcamera = cameras.first;
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
        BlocProvider<CounterCubit1>(
          key: const Key('counter1'),
          create: (context) => CounterCubit1(0),
        ),
        BlocProvider<CounterCubit2>(
          key: const Key('counter2'),
          create: (context) => CounterCubit2(0),
        ),
        BlocProvider<TextFieldCubit>(
          create: (context) => TextFieldCubit(),
        ),
        BlocProvider(
          create: (context) => CameraCubit(firstcamera),
        )
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
                if (state is SettingsPageState)
                  IconButton(
                    onPressed: () async {
                      context.read<CameraCubit>().resetCamera();
                    },
                    icon: Icon(Icons.refresh),
                  ),
                SizedBox(width: 10),
              ],
            ),
            body: state is HomePageState
                ? const HomeScreen()
                : state is ShoppingPageState
                    ? const ShoppingScreen()
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
                  icon: Icon(Icons.barcode_reader),
                  label: 'Scan/Add',
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
