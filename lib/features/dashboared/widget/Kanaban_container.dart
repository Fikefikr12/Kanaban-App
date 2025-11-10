import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_app/features/dashboared/bloc/kanban_bloc.dart';
import 'package:kanban_app/core/model/kanaban_Model.dart';
import 'package:kanban_app/features/dashboared/widget/kanaban_card.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class KanabanContainer extends StatelessWidget {
  final BoardColumn column;
  const KanabanContainer({super.key, required this.column});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KanbanBloc, KanbanState>(
      builder: (context, state) {
        final theme = ShadTheme.of(context).colorScheme;
        final currentColumn = state.columns.firstWhere(
          (col) => col.id == column.id,
          orElse: () => column,
        );

        return DragTarget<kanbanTask>(
          onAccept: (draggedTask) {
            // Only move if dropping in a different column
            if (!currentColumn.tasks.contains(draggedTask)) {
              context.read<KanbanBloc>().add(
                UpdateTaskStatusEvent(
                  taskId: draggedTask.id,
                  newColumnId: currentColumn.id,
                ),
              );
            }
          },
          builder: (context, candidateData, rejectedData) {
            return Container(
              width: 225,
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: _getContainerColor(candidateData),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: candidateData.isNotEmpty ? Colors.blue : Colors.grey,
                  width: candidateData.isNotEmpty ? 2 : 1,
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  // Column Header
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(16),
                      ),
                    ),
                    child: Row(
                      children: [
                        Text(
                          currentColumn.title,
                          style: TextStyle(
                            fontSize: 20,
                            color: theme.foreground,
                          ),
                        ),
                        // Text(   '${currentColumn.tasks.length}',
                      ],
                    ),
                  ),
                  // Task List
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.all(8),
                      child: ListView.builder(
                        itemCount: currentColumn.tasks.length,
                        itemBuilder: (context, index) {
                          final task = currentColumn.tasks[index];
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: KanabanCard(
                              task: task,
                              color: column.color,
                              buttonColor: column.buttonColor,
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Color _getContainerColor(List<kanbanTask?> candidateData) {
    if (candidateData.isNotEmpty) {
      return column.color.withOpacity(0.3); // Highlight when dragging over
    }
    return column.color;
  }
}
