import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SideButtons extends StatelessWidget {
  final Widget child;
  //final Color? havorbackground;
  const SideButtons({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;
    return ShadButton(
      child: child,
      backgroundColor: theme.ring,
      hoverBackgroundColor: theme.ring,
    );
  }
}
