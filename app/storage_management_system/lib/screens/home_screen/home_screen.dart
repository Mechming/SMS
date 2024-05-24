import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/screens/home_screen/home_screen_cubit.dart';
import 'package:storage_management_system/widgets/home_bottom_sheet.dart';

import '../../widgets/modern_listview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NavigationCubit, NavigationStates>(
        builder: (context, state) {
      return Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => showModalBottomSheet(
            context: context,
            builder: (ctx) => MultiBlocProvider(
              providers: [
                BlocProvider<CounterCubit1>(
                  key: Key('counter1'),
                  create: (context) => CounterCubit1(0),
                ),
                BlocProvider<CounterCubit2>(
                  key: Key('counter2'),
                  create: (context) => CounterCubit2(0),
                ),
                BlocProvider<ModalBottomSheetCubit>(
                  create: (context) => ModalBottomSheetCubit(),
                ),
              ],
              child: AddItemHome(),
            ),
          ).then((value) {
            context.read<CounterCubit1>().setCount(0);
            context.read<CounterCubit2>().setCount(0);
          }),
          label: Text('Add Item'),
          icon: Icon(Icons.add),
        ),
        body: modernListView(),
      );
    });
  }
}
