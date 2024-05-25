import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/screens/home_screen/home_screen_cubit.dart';
import 'package:storage_management_system/screens/shopping_screen/shopping_cubit.dart';

class AddItemBottomSheet extends StatelessWidget {
  const AddItemBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          BlocBuilder<TextFieldCubit, String>(
            builder: (context, state) {
              return TextField(
                onChanged: (value) {
                  context.read<TextFieldCubit>().setText(value);
                },
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  labelText: 'Item Name',
                ),
              );
            },
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Add Item'),
            onPressed: () {
              context
                  .read<ShoppingCubit>()
                  .addItem(context.read<TextFieldCubit>().state);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
