import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/screens/home_screen/Items_cubit.dart';
import 'package:storage_management_system/screens/home_screen/home_screen_cubit.dart';

class AddItemHome extends StatelessWidget {
  const AddItemHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          const Text(
            'Add Item!',
            style: TextStyle(fontSize: 24),
          ),
          const Divider(),
          const SizedBox(
            height: 10,
          ),
          BlocBuilder<TextFieldCubit, String>(builder: (context, state) {
            return TextField(
              onChanged: (value) {
                context.read<TextFieldCubit>().setText(value);
              },
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10)),
                  labelText: 'Item Name'),
            );
          }),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    'Target Value:',
                    style: TextStyle(fontSize: 20),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Amount at home:',
                    style: TextStyle(fontSize: 20),
                  ),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  CounterButton(
                    loading: false,
                    onChange: (int val) {
                      val >= 0
                          ? context.read<CounterCubit1>().setCount(val)
                          : null;
                    },
                    count: context.watch<CounterCubit1>().state,
                    countColor: Colors.black,
                    buttonColor: Colors.lightGreen,
                    progressColor: Colors.lightGreen,
                  ),
                  const SizedBox(height: 20),
                  CounterButton(
                    loading: false,
                    onChange: (int val) {
                      context.read<CounterCubit2>().setCount(val);
                    },
                    count: context.watch<CounterCubit2>().state,
                    countColor: Colors.black,
                    buttonColor: Colors.lightGreen,
                    progressColor: Colors.lightGreen,
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            child: const Text('Add Item'),
            onPressed: () {
              ModalBottomSheetState newItem = ModalBottomSheetState(
                itemName: context.read<TextFieldCubit>().state,
                counter1: context.read<CounterCubit1>().state,
                counter2: context.read<CounterCubit2>().state,
              );
              context.read<ItemsCubit>().addItem(newItem);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
