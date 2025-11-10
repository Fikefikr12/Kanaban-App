import 'package:flutter/material.dart';
import 'package:kanban_app/features/dashboared/widget/main_content.dart';
import 'package:kanban_app/features/dashboared/widget/side_view.dart';
import 'package:responsive_framework/responsive_framework.dart';

class Dashboread extends StatelessWidget {
  const Dashboread({super.key});

  @override
  Widget build(BuildContext context) {
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    return Scaffold(
      body: SafeArea(
        child: Scaffold(
          body: Row(
            children: [
              if (!isMobile)
                SizedBox(
                  width: isMobile
                      ? 60
                      : isTablet
                      ? 65
                      : 80,
                  child: SideView(),
                ),
              Expanded(child: MainContent()),
            ],
          ),
        ),
      ),
    );
  }
}
