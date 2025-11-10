import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class AppTheme {
  static final lightMode = ShadThemeData(
    brightness: Brightness.light,
    colorScheme: ShadColorScheme(
      background: Colors.white,
      foreground: Color(0xFF0A0A0A),
      card: Colors.grey.shade300,
      cardForeground: Color(0xFF0A0A0A),
      popover: Colors.white38,
      popoverForeground: Color(0xFF0A0A0A),
      primary: Colors.black,
      primaryForeground: Colors.black38,
      secondary: Color(0xFFF2F2F7),
      secondaryForeground: Color(0xFF1C1C1E),
      muted: Colors.grey.shade300,
      mutedForeground: Colors.grey.shade500,
      accent: Color.fromARGB(255, 163, 188, 214),
      accentForeground: Colors.black,
      destructive: Color(0xFFFF3B30),
      destructiveForeground: Colors.white,
      border: Color(0xFFC6C6C8),
      input: Color(0xFFF2F2F7),
      ring: Colors.grey.shade200,
      selection: Colors.black12,
    ),
  );

  static final darkMode = ShadThemeData(
    brightness: Brightness.dark,
    colorScheme: ShadColorScheme(
      background: Color(0xFF121212),
      foreground: Colors.white,
      card: Color(0xFF1C1C1E),
      cardForeground: Colors.white,
      popover: Colors.black,
      popoverForeground: Colors.white,
      primary: Colors.white, // for selecterd date
      primaryForeground: Colors.grey,
      secondary: Color(0xFF121212),
      secondaryForeground: Colors.white,
      muted: Color(0xFF2C2C2E),
      mutedForeground: Colors.white,
      accent: const Color.fromARGB(255, 112, 108, 108),
      accentForeground: Colors.white,
      destructive: Color(0xFFFF453A),
      destructiveForeground: Colors.white,
      border: Color(0xFF38383A),
      input: Color(0xFF2C2C2E),
      ring: Colors.grey.shade900,
      selection: Color(0xFF0A84FF).withOpacity(0.2),
    ),
  );
}
