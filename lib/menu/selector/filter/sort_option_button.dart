import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mlcf/providers/emission_manager.dart';
import 'package:mlcf/providers/selected_options.dart';
import 'package:provider/provider.dart';

const List<SortOption> options = <SortOption>[SortOption.name, SortOption.emission];

class SortButton extends StatefulWidget {
  const SortButton({super.key});

  @override
  State<SortButton> createState() => _SortButtonState();
}

class _SortButtonState extends State<SortButton> {

  String dropdownValue = getSortOptionNameToDisplay(options.first);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.fromLTRB(0, 20, 0, 10),
          child: const Text(
            "Order by",
            style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ),
        DropdownButton<String>(
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
              context.read<SelectedOptions>().updateSortOption(dropdownValue);
            });
            },
          items: options.map<DropdownMenuItem<String>>((SortOption option) {

            String sortOptionName = getSortOptionNameToDisplay(option);

            return DropdownMenuItem<String>(
              value: sortOptionName,
              child: Text(sortOptionName),
            );
          }).toList(),
        )
      ],
    );

  }
}