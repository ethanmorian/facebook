import 'package:flutter/material.dart';

class GenderRadioTile extends StatelessWidget {
  final String title;
  final String value;
  final String? selectedValue;
  final Function(String?)? onChanged;

  const GenderRadioTile({
    super.key,
    required this.title,
    required this.value,
    required this.selectedValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title),
        Radio.adaptive(
          value: value,
          groupValue: selectedValue,
          onChanged: onChanged,
        ),
      ],
    );
  }
}
