import 'package:flutter/material.dart';
import 'package:kanban_app/features/dashboared/widget/side_buttons.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class MobileDrawer extends StatelessWidget {
  MobileDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    if (!isMobile && Scaffold.of(context).isDrawerOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pop();
      });
    }
    return Drawer(
      //   backgroundColor: theme.popover,
      width: 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 30),
          Center(
            child: Text(
              "Menu",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          SizedBox(height: 30),
          Divider(),

          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.only(left: 20),
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0),
                child: Column(
                  spacing: 5,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      child: Container(
                        height: 50,
                        width: 50,
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
                      padding: const EdgeInsets.only(top: 10, bottom: 15),
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
                    SideButtons(
                      child: const Icon(Icons.sms, color: Colors.grey),
                    ),
                    SideButtons(
                      child: const Icon(Icons.settings, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30, top: 10),
            child: SideButtons(
              child: const Icon(Icons.logout, color: Colors.grey),
            ),
          ),
        ],
      ),
    );
  }
}
