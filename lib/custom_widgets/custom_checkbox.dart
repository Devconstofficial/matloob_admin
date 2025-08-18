import 'package:flutter/material.dart';
import '../utils/app_colors.dart';
import 'custom_text.dart';

class CustomCheckBox extends StatelessWidget {
  final String label;
  final String groupValue;
  final void Function(String) onChanged;

  const CustomCheckBox({
    super.key,
    required this.label,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = label == groupValue;

    return GestureDetector(
      onTap: () => onChanged(isSelected ? '' : label),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 14,
            width: 14,
            margin: const EdgeInsets.only(top: 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              color: isSelected ? kPrimaryColor : Colors.transparent,
              border: Border.all(color: isSelected ? kPrimaryColor : kBlackColor.withOpacity(0.5)),
            ),
            child: isSelected
                ? Center(child: Icon(Icons.check, size: 8, color: kBlackColor))
                : null,
          ),
          const SizedBox(width: 6),
          Column(
            children: [
              CustomText(
                text: label,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
