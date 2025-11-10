import 'package:flutter/material.dart';
import 'package:kanban_app/features/dashboared/widget/side_buttons.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class SideView extends StatelessWidget {
  const SideView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;

    return Container(
      decoration: BoxDecoration(
        color: theme.popover,
        border: Border(right: BorderSide(color: theme.border)),
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(15)),
      ),
      // ✅ Use Column with Expanded + SingleChildScrollView for body only
      child: Column(
        children: [
          // Scrollable content
          Expanded(
            child: SingleChildScrollView(
              //padding: const EdgeInsets.only(bottom: 60), // space for logout for compressed
              child: Column(
                spacing: 5,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 2,
                      vertical: 18,
                    ),
                    child: Container(
                      height: 40,
                      width: 40,
                      decoration: BoxDecoration(color: theme.popover),
                      child: Center(
                        child: Text(
                          "soy\ncou",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.blueAccent.shade100,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, bottom: 30),
                    child: SideButtons(child: Image.asset("assets/p3.png")),
                  ),
                  SideButtons(
                    child: Icon(Icons.home, color: theme.primaryForeground),
                  ),
                  ShadButton(
                    backgroundColor: Colors.pink.shade200,
                    child: const Icon(Icons.window, color: Colors.black),
                  ),
                  SideButtons(
                    child: const Icon(Icons.search, color: Colors.grey),
                  ),
                  SideButtons(
                    child: const Icon(Icons.bar_chart, color: Colors.grey),
                  ),
                  SideButtons(
                    child: const Icon(Icons.layers, color: Colors.grey),
                  ),
                  SideButtons(
                    child: const Icon(Icons.lock_clock, color: Colors.grey),
                  ),
                  SideButtons(
                    child: const Icon(Icons.person, color: Colors.grey),
                  ),
                  SideButtons(
                    child: const Icon(
                      Icons.currency_bitcoin,
                      color: Colors.grey,
                    ),
                  ),
                  SideButtons(child: const Icon(Icons.sms, color: Colors.grey)),
                  SideButtons(
                    child: const Icon(Icons.settings, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ),

          // Fixed logout icon at bottom
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 10),
            child: Container(
              decoration: BoxDecoration(
                color: theme.card,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: theme.border),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              padding: const EdgeInsets.all(8),
              child: const Icon(Icons.logout, color: Colors.grey, size: 24),
            ),
          ),
        ],
      ),
    );
  }
}
