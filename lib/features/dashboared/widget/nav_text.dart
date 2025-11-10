import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class NavText extends StatelessWidget {
  final String text;
  const NavText({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;
    return Text(text, style: TextStyle(color: theme.foreground));
  }
}
