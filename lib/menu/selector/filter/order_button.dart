import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mlcf/providers/emission_manager.dart';
import 'package:mlcf/providers/selected_options.dart';
import 'package:provider/provider.dart';

const List<OrderOption> options = <OrderOption>[OrderOption.asc, OrderOption.desc];

class OrderButton extends StatefulWidget {
  const OrderButton({super.key});

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {

  String dropdownValue = getOrderOptionNameToDisplay(options.first);

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      style: const TextStyle(color: Colors.greenAccent),
      underline: Container(
        height: 2,
        color: Colors.green,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          dropdownValue = value!;
          context.read<SelectedOptions>().updateOrderOption(dropdownValue);
        });
      },
      items: options.map<DropdownMenuItem<String>>((OrderOption option) {

        String orderOptionToDisplay = getOrderOptionNameToDisplay(option);

        return DropdownMenuItem<String>(
          value: orderOptionToDisplay,
          child: Text(orderOptionToDisplay),
        );
      }).toList(),
    );
  }
}