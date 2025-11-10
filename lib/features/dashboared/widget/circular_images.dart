import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class CircularImages extends StatelessWidget {
  const CircularImages({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    return Row(
      children: [
        ...List.generate(
          7,
          (index) => Transform.translate(
            offset: Offset(index * -8.0, 0),
            child: CircleAvatar(
              radius: isTablet
                  ? 14
                  : isMobile
                  ? 14
                  : 18,
              child: Image.asset("assets/p${index + 1}.png"),
              backgroundColor: theme.mutedForeground,
            ),
          ),
        ),
        Transform.translate(
          offset: Offset(-55, 0),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? 4 : 8,
              vertical: isMobile ? 4 : 8,
            ),
            decoration: BoxDecoration(
              color: Color(0xFF121212),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.white60),
            ),
            child: Text(
              "+5",
              style: TextStyle(
                color: Colors.white,
                fontSize: isTablet
                    ? 12
                    : isMobile
                    ? 14
                    : 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
