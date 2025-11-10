part of 'kanban_bloc.dart';

class KanbanState {
  final List<BoardColumn> columns;
  final bool isDark;

  KanbanState({List<BoardColumn>? columns, this.isDark = false})
    : columns = columns ?? [];

  KanbanState copyWith({List<BoardColumn>? columns, bool? isDark}) {
    return KanbanState(
      columns: columns ?? this.columns,
      isDark: isDark ?? this.isDark,
    );
  }
}
