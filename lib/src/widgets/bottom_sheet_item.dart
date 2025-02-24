import 'package:flutter/material.dart';

class BottomSheetItem extends StatelessWidget {
  final String description;
  final VoidCallback onTap;

  const BottomSheetItem({
    super.key,
    required this.description,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [Text(description), Icon(Icons.chevron_right)],
      ),
    );
  }
}
