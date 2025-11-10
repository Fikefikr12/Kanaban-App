part of 'kanban_bloc.dart';

abstract class KanbanEvent {}

class AddTaskEvent extends KanbanEvent {
  final String columnId; // place we add card
  final kanbanTask task; // task added

  AddTaskEvent({required this.columnId, required this.task});
}

class UpdateTaskStatusEvent extends KanbanEvent {
  final String taskId;
  final String newColumnId;

  UpdateTaskStatusEvent({required this.taskId, required this.newColumnId});
}

class RemoveTaskCardEvent extends KanbanEvent {
  final kanbanTask removedItem;

  RemoveTaskCardEvent({required this.removedItem});
}

class ThemeChangeEvent extends KanbanEvent {
  final bool isChangeMode;
  ThemeChangeEvent({required this.isChangeMode});
}
