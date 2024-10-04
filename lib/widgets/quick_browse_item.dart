// /lib/widgets/quick_browse_item.dart
import 'package:flutter/material.dart';

class QuickBrowseItem extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String label;
  final Color backgroundColor;
  void Function()? onTap;
  QuickBrowseItem({
    super.key,
    required this.icon,
    required this.iconColor,
    required this.label,
    required this.backgroundColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    double widthScreen = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 5.0),
        width: widthScreen / 3,
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: iconColor),
            const SizedBox(height: 5),
            Text(label),
          ],
        ),
      ),
    );
  }
}
