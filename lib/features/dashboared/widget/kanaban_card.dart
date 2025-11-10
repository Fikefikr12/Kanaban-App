import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_app/features/dashboared/bloc/kanban_bloc.dart';
import 'package:kanban_app/core/model/kanaban_Model.dart';
import 'package:kanban_app/features/dashboared/widget/button_Container.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class KanabanCard extends StatelessWidget {
  final kanbanTask task;
  final Color color;
  final Color buttonColor;

  const KanabanCard({
    super.key,
    required this.task,
    required this.color,
    required this.buttonColor,
  });

  void _removeTask(BuildContext context) {
    context.read<KanbanBloc>().add(RemoveTaskCardEvent(removedItem: task));
  }

  @override
  Widget build(BuildContext context) {
    return LongPressDraggable<kanbanTask>(
      data: task,
      feedback: Material(
        elevation: 4,
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color(0xFF121212),
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: _buildCardContent(opacity: 0.8, context: context),
        ),
      ),
      childWhenDragging: Opacity(opacity: 0.5, child: _buildCard(context)),
      child: _buildCard(context),
    );
  }

  Widget _buildCard(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;
    return ShadCard(
      padding: EdgeInsets.only(left: 5, top: 5, bottom: 5),
      backgroundColor: theme.card,
      //   width: 150,
      child: _buildCardContent(context: context),
    );
  }

  Widget _buildCardContent({
    double opacity = 1.0,
    required BuildContext context,
  }) {
    final theme = ShadTheme.of(context).colorScheme;
    return Opacity(
      opacity: opacity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            task.title,
            style: TextStyle(
              color: theme.cardForeground,
              fontWeight: FontWeight.w300,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 6),
          SizedBox(
            width: 200,
            child: Text(
              overflow: TextOverflow.clip,
              task.description,
              style: TextStyle(color: theme.cardForeground, fontSize: 13),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              ...List.generate(
                task.images.length.clamp(0, 3),
                (index) => Transform.translate(
                  offset: Offset(index * -14, 0),
                  child: CircleAvatar(
                    backgroundColor: Colors.lightBlueAccent,
                    radius: 14,
                    child: ClipOval(
                      child: Image.asset(
                        task.images[index],
                        width: 28,
                        height: 28,
                      ),
                    ),
                  ),
                ),
              ),
              // if (task.images.length > 2)
              //   Transform.translate(
              //     offset: const Offset(-40, 0),
              //     child: Container(
              //       padding: const EdgeInsets.symmetric(
              //         horizontal: 4,
              //         vertical: 4,
              //       ),
              //       decoration: BoxDecoration(
              //         color: Colors.white,
              //         borderRadius: BorderRadius.circular(20),
              //         border: Border.all(color: Colors.white),
              //       ),
              //       child: Text(
              //         "+${task.images.length - 2}",
              //         style: const TextStyle(
              //           color: Colors.grey,
              //           fontSize: 12,
              //           fontWeight: FontWeight.w500,
              //         ),
              //       ),
              //     ),
              //   ),
              const Spacer(),
              const Icon(Icons.comment, size: 16, color: Colors.grey),
              Text(
                " ${task.comments}",
                style: const TextStyle(color: Colors.grey),
              ),
              const SizedBox(width: 16),
              const Icon(Icons.attachment, size: 16, color: Colors.grey),
              Text(
                " ${task.attachments}",
                style: const TextStyle(color: Colors.grey),
              ),
              IconButton(
                onPressed: () => _removeTask(context),
                icon: const Icon(Icons.delete),
                color: Colors.red,
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            // mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ButtonContainer(
                leadingIcon: Icons.circle,
                text: task.tag,
                bgColor: buttonColor,
              ),
              if (task.dueDate != null)
                Padding(
                  padding: const EdgeInsets.only(right: 6),
                  child: ButtonContainer(
                    text: task.deadlineText,
                    bgColor: Colors.pinkAccent,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
