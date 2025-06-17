import 'package:flutter/material.dart';

class KategoriFilter extends StatelessWidget {
  final String selectedValue;
  final ValueChanged<String> onChanged;

  const KategoriFilter({
    super.key,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: selectedValue,
      underline: const SizedBox(),
      items: const ['All', 'Kuliah', 'Organisasi'].map((value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (val) {
        if (val != null) onChanged(val);
      },
    );
  }
}
