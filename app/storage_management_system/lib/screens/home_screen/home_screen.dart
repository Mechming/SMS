import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/screens/home_screen/home_screen_cubit.dart';
import 'package:storage_management_system/widgets/modal_bottom_sheet.dart';

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
            builder: (ctx) => addItemBottomSheet,
          ),
          label: Text('Add Item'),
          icon: Icon(Icons.add),
        ),
        body: modernListView(),
      );
    });
  }
}
