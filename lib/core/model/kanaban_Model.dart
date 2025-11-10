import 'dart:ui';
import 'package:uuid/uuid.dart';

class kanbanTask {
  final String id;
  final String title;
  final String description;
  final List<dynamic> images;
  //final String status;
  final String tag;
  final int comments;
  final int attachments;
  final bool hasDetailedDescription;
  final DateTime? dueDate;

  kanbanTask({
    String? id,
    required this.title,
    required this.description,
    required this.images,
    //required this.status,
    required this.tag,
    required this.comments,
    required this.attachments,
    this.hasDetailedDescription = false,
    this.dueDate,
  }) : id =
           id ??
           const Uuid()
               .v4() // auto generate id
               ;

  /// 🔹 Helper to get formatted month text
  String get deadlineText {
    // if (dueDate == null) return 'No deadline';
    if (dueDate == null) return '';
    final now = DateTime.now(); //1
    final difference = dueDate!.difference(
      now,
    ); // 2 show difference betewween now and duedate
    final month = _monthName(dueDate!.month);
    return '$month deadline';
  }

  String _monthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];
    return months[month - 1];
  }

  kanbanTask copyWith({
    String? id,
    String? title,
    String? description,
    List<String>? images,
    String? tag,
    int? comments,
    int? attachments,
    DateTime? dueDate,
  }) {
    return kanbanTask(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      tag: tag ?? this.tag,
      comments: comments ?? this.comments,
      attachments: attachments ?? this.attachments,
      dueDate: dueDate ?? this.dueDate,
      // status: '',
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'description': description,
    'images': images,
    'tag': tag,
    'comments': comments,
    'attachments': attachments,
    'hasDetailedDescription': hasDetailedDescription,
    'dueDate': dueDate?.toIso8601String(),
  };

  factory kanbanTask.fromJson(Map<String, dynamic> json) => kanbanTask(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    images: List<String>.from(json['images']),
    tag: json['tag'],
    comments: json['comments'],
    attachments: json['attachments'],
    hasDetailedDescription: json['hasDetailedDescription'],
    dueDate: json['dueDate'] != null ? DateTime.parse(json['dueDate']) : null,
  );
}

class BoardColumn {
  final String id;
  final String title;
  final List<kanbanTask> tasks;
  final Color color;
  final Color buttonColor;
  BoardColumn({
    required this.id,
    required this.buttonColor,
    required this.title,
    required this.tasks,
    required this.color,
  });

  BoardColumn copyWith({
    String? id,
    String? title,
    Color? color,
    Color? buttonColor,
    List<kanbanTask>? tasks,
  }) {
    return BoardColumn(
      id: id ?? this.id,
      title: title ?? this.title,
      color: color ?? this.color,
      buttonColor: buttonColor ?? this.buttonColor,
      tasks: tasks ?? this.tasks,
    );
  }

  // ✅ JSON serialization
  Map<String, dynamic> toJson() => {
    'id': id,
    'title': title,
    'color': color.value,
    'buttonColor': buttonColor.value,
    'tasks': tasks.map((t) => t.toJson()).toList(),
  };

  factory BoardColumn.fromJson(Map<String, dynamic> json) => BoardColumn(
    id: json['id'],
    title: json['title'],
    color: Color(json['color']),
    buttonColor: Color(json['buttonColor']),
    tasks: (json['tasks'] as List<dynamic>)
        .map((t) => kanbanTask.fromJson(t))
        .toList(),
  );
}
