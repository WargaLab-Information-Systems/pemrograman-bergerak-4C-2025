import 'package:flutter/material.dart';

class KategoriDropdown extends StatelessWidget {
  final String value;
  final Function(String) onChanged;

  const KategoriDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: value,
      isExpanded: true,
      items: ['Kuliah', 'Organisasi'].map((e) {
        return DropdownMenuItem(
          value: e,
          child: Text(e),
        );
      }).toList(),
      onChanged: (val) {
        if (val != null) onChanged(val);
      },
    );
  }
}
