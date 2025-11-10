import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_app/features/dashboared/widget/button_Container.dart';
import 'package:kanban_app/features/dashboared/widget/circular_images.dart';
import 'package:kanban_app/features/dashboared/widget/header_view.dart';
import 'package:kanban_app/features/dashboared/widget/kanaban_view.dart';
import 'package:kanban_app/features/dashboared/widget/kanban_dialoug.dart';
import 'package:kanban_app/features/dashboared/widget/mobile_drawer.dart';
import 'package:kanban_app/features/dashboared/widget/nav_text.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../bloc/kanban_bloc.dart';

class MainContent extends StatelessWidget {
  const MainContent({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;

    //final size = MediaQuery.of(context).size.width;

    return BlocBuilder<KanbanBloc, KanbanState>(
      builder: (context, state) {
        return Scaffold(
          drawer: MobileDrawer(),
          body: Column(
            children: [
              HeaderView(),
              SizedBox(height: 5),

              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 16, top: 12),
                    child: Row(
                      spacing: isMobile ? 0 : 10,
                      children: [
                        NavText(text: "Projects"),
                        Icon(Icons.chevron_right, color: theme.foreground),
                        NavText(text: "interationals"),
                        Icon(Icons.chevron_right, color: theme.foreground),
                        NavText(text: "ProductWeb"),
                      ],
                    ),
                  ),
                  SizedBox(height: 10), // Added spacing
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 12),
                    child: Row(
                      spacing: isMobile ? 8 : 15,
                      children: [
                        Text(
                          "All Sprints",
                          style: TextStyle(
                            color: theme.foreground,
                            fontSize: isMobile ? 12 : 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Spacer(),
                        Icon(
                          Icons.star,
                          color: Colors.grey.shade600,
                          size: isMobile ? 14 : 30,
                        ),
                        ShadButton(
                          padding: EdgeInsets.only(
                            left: isMobile ? 3 : 5,
                            right: isMobile ? 3 : 5,
                          ),
                          child: Text(
                            "Complete sprint",
                            style: TextStyle(color: Colors.black),
                          ),
                          backgroundColor: const Color.fromARGB(
                            255,
                            243,
                            185,
                            181,
                          ),
                        ),
                        Icon(
                          Icons.share,
                          color: Colors.grey.shade600,
                          size: isMobile ? 18 : 30,
                        ),
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => KanbanDialoug(),
                            );
                          },
                          child: Container(
                            width: isMobile ? 30 : 40,
                            height: isMobile ? 30 : 40,
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              border: Border.all(color: Colors.grey.shade600),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Icon(
                              //  Icons.more_horiz,
                              Icons.add,
                              size: 30,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10), // Added spacing
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0, right: 12),
                    child: isMobile
                        ? Expanded(
                            child: Column(
                              spacing: isTablet ? 10 : 15,
                              children: [
                                ShadInput(
                                  leading: Icon(
                                    Icons.search,
                                    color: Colors.white38,
                                  ),
                                  placeholder: Text("Search"),
                                  style: TextStyle(color: Colors.white),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: CircularImages(),
                                ),
                                //  Spacer(),
                                Row(
                                  spacing: 8,
                                  children: [
                                    ButtonContainer(
                                      text: "Only my isues",
                                      bgColor: Colors.grey,
                                    ),
                                    ButtonContainer(
                                      text: "Recently updated",
                                      bgColor: Colors.grey,
                                    ),
                                    _buildButtonContainer(
                                      text: "All sprints",
                                      bgColor: Colors.grey,
                                      icon: Icons.checklist_rtl_sharp,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          )
                        : Row(
                            spacing: isTablet ? 10 : 15,
                            children: [
                              Expanded(
                                flex: 2,
                                child: ShadInput(
                                  leading: Icon(
                                    Icons.search,
                                    color: Colors.white38,
                                  ),
                                  placeholder: Text("Search"),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 5),
                                child: CircularImages(),
                              ),
                              Spacer(),
                              ButtonContainer(
                                text: "Only my isues",
                                bgColor: Colors.grey,
                              ),
                              ButtonContainer(
                                text: "Recently updated",
                                bgColor: Colors.grey,
                              ),
                              _buildButtonContainer(
                                text: "All sprints",
                                bgColor: Colors.grey,
                                icon: Icons.checklist_rtl_sharp,
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
              Expanded(
                // flex: (size > 1500) ? 9 : 5,
                child: KanbanView(columns: state.columns),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _buildButtonContainer extends StatelessWidget {
  final String text;
  final Color bgColor;
  final IconData? icon;
  const _buildButtonContainer({
    required this.text,
    required this.bgColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final isTablet = ResponsiveBreakpoints.of(context).isTablet;
    final isMobile = ResponsiveBreakpoints.of(context).isMobile;
    return Container(
      padding: EdgeInsets.only(
        left: isTablet ? 8 : 10,
        top: 5,
        bottom: 5,
        right: isTablet ? 4 : 8,
      ),
      decoration: BoxDecoration(
        color: bgColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: bgColor.withOpacity(0.5), width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            style: TextStyle(
              fontSize: isTablet
                  ? 10
                  : isMobile
                  ? 9
                  : 12,
              color: bgColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Icon(icon, color: Colors.white),
          ),
        ],
      ),
    );
  }
}

//
