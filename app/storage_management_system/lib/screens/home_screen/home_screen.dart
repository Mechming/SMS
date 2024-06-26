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
            isScrollControlled: true,
            context: context,
            builder: (ctx) => MultiBlocProvider(
              providers: [
                BlocProvider<CounterCubit1>(
                  key: const Key('counter1'),
                  create: (context) => CounterCubit1(0),
                ),
                BlocProvider<CounterCubit2>(
                  key: const Key('counter2'),
                  create: (context) => CounterCubit2(0),
                ),
                BlocProvider<ModalBottomSheetCubit>(
                  create: (context) => ModalBottomSheetCubit(),
                ),
              ],
              child: const SizedBox(height: 600, child: AddItemHome()),
            ),
          ).then((value) {
            context.read<CounterCubit1>().setCount(0);
            context.read<CounterCubit2>().setCount(0);
            context.read<TextFieldCubit>().setText('');
          }),
          label: const Text('Add Item'),
          icon: const Icon(Icons.add),
        ),
        body: modernListView(),
      );
    });
  }
}
