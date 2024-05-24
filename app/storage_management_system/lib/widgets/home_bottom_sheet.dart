import 'package:counter_button/counter_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:storage_management_system/screens/home_screen/Items_cubit.dart';
import 'package:storage_management_system/screens/home_screen/home_screen_cubit.dart';

class AddItemHome extends StatelessWidget {
  final TextEditingController controller = TextEditingController();

  AddItemHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            'Add Item!',
            style: TextStyle(fontSize: 24),
          ),
          Divider(),
          TextField(
            controller: controller,
            decoration: InputDecoration(
                border:
                    OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
                labelText: 'Item Name'),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Amount that always should be at home: ',
                style: TextStyle(fontSize: 20),
              ),
              CounterButton(
                loading: false,
                onChange: (int val) {
                  context.read<CounterCubit1>().setCount(val);
                },
                count: context.watch<CounterCubit1>().state,
                countColor: Colors.black,
                buttonColor: Colors.lightGreen,
                progressColor: Colors.lightGreen,
              )
            ],
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                'Amount that you have at home: ',
                style: TextStyle(fontSize: 20),
              ),
              CounterButton(
                loading: false,
                onChange: (int val) {
                  context.read<CounterCubit2>().setCount(val);
                },
                count: context.watch<CounterCubit2>().state,
                countColor: Colors.black,
                buttonColor: Colors.lightGreen,
                progressColor: Colors.lightGreen,
              )
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            child: Text('Add Item'),
            onPressed: () {
              ModalBottomSheetState newItem = ModalBottomSheetState(
                itemName: controller.text,
                counter1: context.read<CounterCubit1>().state,
                counter2: context.read<CounterCubit2>().state,
              );
              context.read<ItemsCubit>().addItem(newItem);
            },
          ),
        ],
      ),
    );
  }
}
