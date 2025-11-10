import 'package:flutter/material.dart';

class ButtonContainer extends StatelessWidget {
  final String text;
  final Color bgColor;
  final IconData? leadingIcon;
  final bool isSelected;
  final IconData? icon;
  const ButtonContainer({
    super.key,
    required this.text,
    required this.bgColor,
    this.leadingIcon,
    this.icon,
    this.isSelected = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 2, top: 3, bottom: 3, right: 5),
      decoration: BoxDecoration(
        color: isSelected ? bgColor : bgColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isSelected ? bgColor : bgColor.withOpacity(0.5),
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (leadingIcon != null) ...[
            Icon(
              leadingIcon,
              size: 10,
              color: isSelected ? Colors.white : bgColor,
            ),
            const SizedBox(width: 4),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: 10,
              color: isSelected ? Colors.white : bgColor,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
          // Icon(icon, color: Colors.white),
        ],
      ),
    );
  }
}

//
