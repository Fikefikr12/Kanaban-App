import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:kanban_app/core/model/kanaban_Model.dart';
import 'package:kanban_app/features/dashboared/widget/Kanaban_container.dart';

class KanbanView extends StatelessWidget {
  final List<BoardColumn> columns;

  const KanbanView({super.key, required this.columns});

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: EdgeInsets.only(left: 10),
      height: MediaQuery.of(context).size.height * 0.7, // Constrained height
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(
          dragDevices: {
            PointerDeviceKind.mouse,
            PointerDeviceKind.trackpad,
            PointerDeviceKind.touch,
          },
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: columns
                .map((col) => KanabanContainer(column: col))
                .toList(),
          ),
        ),
      ),
    );
  }
}
