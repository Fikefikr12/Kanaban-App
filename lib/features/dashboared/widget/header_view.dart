import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_app/features/dashboared/bloc/kanban_bloc.dart';
import 'package:kanban_app/features/dashboared/widget/nav_text.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HeaderView extends StatelessWidget {
  const HeaderView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final ShadPopoverController _popoverController = ShadPopoverController();
    return Container(
      padding: EdgeInsets.only(
        left: isTablet
            ? 10
            : isMobile
            ? 5
            : 20,

        right: 12,
      ),
      height: 70,
      decoration: BoxDecoration(
        // color: theme.foreground,
        border: Border(bottom: BorderSide(color: theme.border)),
      ),
      child: Row(
        spacing: isTablet
            ? 9
            : isMobile
            ? 10
            : 10,
        children: [
          if (!isMobile)
            Row(
              spacing: isTablet ? 10 : 20,
              children: [
                NavText(text: "Dashboard"),
                NavText(text: "Leads"),
                NavText(text: "Projects"),
                NavText(text: "Teams"),
                NavText(text: "News"),
                NavText(text: "Library"),
                NavText(text: "Contacts"),
              ],
            ),
          if (isMobile)
            IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.menu),
            ),
          Spacer(),
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(Icons.email_rounded, color: Colors.grey),
          ),
          Icon(Icons.notifications_active, color: Colors.grey),
          BlocBuilder<KanbanBloc, KanbanState>(
            builder: (context, state) {
              return IconButton(
                color: Colors.grey,
                onPressed: () {
                  final currentDark = context.read<KanbanBloc>().state.isDark;
                  context.read<KanbanBloc>().add(
                    ThemeChangeEvent(isChangeMode: !currentDark),
                  );
                },
                icon: Icon(
                  context.read<KanbanBloc>().state.isDark
                      ? Icons.dark_mode
                      : Icons.light_mode,
                ),
              );
            },
          ),

          if (isMobile)
            ShadPopover(
              decoration: ShadDecoration(color: theme.background),
              controller: _popoverController,
              child: ShadButton(
                child: Icon(Icons.more_vert),
                backgroundColor: theme.background,
                hoverBackgroundColor: theme.background,
                onPressed: _popoverController.toggle,
              ),
              popover: (context) => SizedBox(
                //   color: theme.background,
                width: 90,
                height: 180,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    spacing: 8,
                    children: [
                      NavText(text: "Dashboard"),
                      NavText(text: "Leads"),
                      NavText(text: "Projects"),
                      NavText(text: "Teams"),
                      NavText(text: "News"),
                      NavText(text: "Library"),
                      NavText(text: "Contacts"),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
