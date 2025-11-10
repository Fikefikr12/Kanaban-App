import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:kanban_app/core/model/kanaban_Model.dart';

part 'kanban_event.dart';
part 'kanban_state.dart';

//class KanbanBloc extends Bloc<KanbanEvent, KanbanState> {
class KanbanBloc extends HydratedBloc<KanbanEvent, KanbanState> {
  KanbanBloc() : super(KanbanState(columns: _initialColumns)) {
    on<AddTaskEvent>(_addTaskEvent);
    on<UpdateTaskStatusEvent>(_onUpdateTaskStatus);
    on<ThemeChangeEvent>(themeChangeEvent);
    on<RemoveTaskCardEvent>(_removeTaskCardEvent);
  }

  static final List<BoardColumn> _initialColumns = [
    BoardColumn(
      id: 'not_started',
      title: 'Not Started',
      color: Color(0x171e2bbb),
      buttonColor: Colors.blue.withOpacity(0.6),
      tasks: [],
    ),
    BoardColumn(
      id: 'ready',
      title: 'Ready',
      color: Color(0x231f2eee),
      buttonColor: Colors.purpleAccent.withOpacity(0.2),
      tasks: [],
    ),
    BoardColumn(
      id: 'in_progress',
      title: 'In Progress',
      color: Colors.purple.shade900.withOpacity(0.2),
      buttonColor: Colors.blue.withOpacity(0.6),
      tasks: [],
    ),
    BoardColumn(
      id: 'blocked',
      title: 'Blocked',
      color: const Color.fromARGB(255, 43, 4, 2).withOpacity(0.3),
      buttonColor: const Color.fromARGB(255, 77, 50, 82).withOpacity(0.2),
      tasks: [],
    ),
    BoardColumn(
      id: 'done',
      title: 'Done',
      color: const Color.fromARGB(255, 48, 68, 37).withOpacity(0.5),
      buttonColor: Colors.green.withOpacity(0.6),
      tasks: [],
    ),
    BoardColumn(
      id: 'canceled',
      title: 'Canceled',
      color: const Color.fromARGB(255, 30, 31, 30).withOpacity(0.2),
      buttonColor: const Color.fromARGB(255, 128, 129, 128).withOpacity(0.6),
      tasks: [],
    ),
  ];

  void _addTaskEvent(AddTaskEvent event, Emitter<KanbanState> emit) {
    final updatedColumns = state.columns.map((column) {
      if (column.id == event.columnId) {
        return column.copyWith(tasks: [...column.tasks, event.task]);
      }
      return column;
    }).toList();

    emit(state.copyWith(columns: updatedColumns));
  }

  void _onUpdateTaskStatus(
    UpdateTaskStatusEvent event,
    Emitter<KanbanState> emit,
  ) {
    kanbanTask? taskToMove;
    String? sourceColumnId;

    // Find the task and its source column
    for (final column in state.columns) {
      for (final task in column.tasks) {
        if (task.id == event.taskId) {
          taskToMove = task;
          sourceColumnId = column.id;
          break;
        }
      }
      if (taskToMove != null) break;
    }

    if (taskToMove == null || sourceColumnId == null) {
      print("Task not found or invalid source column");
      return;
    }

    if (sourceColumnId == event.newColumnId) return;

    // Update columns
    final updatedColumns = state.columns.map((column) {
      if (column.id == sourceColumnId) {
        return column.copyWith(
          tasks: column.tasks.where((task) => task.id != event.taskId).toList(),
        );
      } else if (column.id == event.newColumnId) {
        return column.copyWith(tasks: [...column.tasks, taskToMove!]);
      } else {
        return column;
      }
    }).toList();

    emit(state.copyWith(columns: updatedColumns));
  }

  FutureOr<void> themeChangeEvent(
    ThemeChangeEvent event,
    Emitter<KanbanState> emit,
  ) {
    emit(state.copyWith(isDark: event.isChangeMode));
  }

  FutureOr<void> _removeTaskCardEvent(
    RemoveTaskCardEvent event,
    Emitter<KanbanState> emit,
  ) {
    final updatedColumns = state.columns.map((column) {
      // Check if this column contains the task to remove
      final containTask = column.tasks.contains(event.removedItem);
      if (containTask) {
        return BoardColumn(
          id: column.id,
          title: column.title,
          tasks: List<kanbanTask>.from(column.tasks)..remove(event.removedItem),
          color: column.color,
          buttonColor: column.buttonColor,
        );
      }

      // Return original column if task not found here
      return column;
    }).toList();
    emit(state.copyWith(columns: updatedColumns));
  }

  ///////////////
  @override
  KanbanState? fromJson(Map<String, dynamic> json) {
    try {
      final columnsJson = json['columns'] as List<dynamic>?;
      final columns = columnsJson != null
          ? columnsJson.map((c) => BoardColumn.fromJson(c)).toList()
          : _initialColumns;

      return KanbanState(
        isDark: json['isDark'] as bool? ?? false,
        //  columns: columns,
        columns: _initialColumns,
      );
    } catch (e) {
      debugPrint("Error restoring KanbanState: $e");
      return KanbanState(columns: _initialColumns);
    }
  }

  @override
  Map<String, dynamic>? toJson(KanbanState state) {
    return {
      'isDark': state.isDark,
      'columns': state.columns.map((col) => col.toJson()).toList(),
    };
  }
}
