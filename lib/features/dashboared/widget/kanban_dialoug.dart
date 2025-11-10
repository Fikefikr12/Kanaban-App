import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_app/features/dashboared/bloc/kanban_bloc.dart';
import 'package:kanban_app/core/model/kanaban_Model.dart';
import 'package:kanban_app/features/dashboared/widget/button_Container.dart';
import 'package:kanban_app/features/dashboared/widget/circular_images.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class KanbanDialoug extends StatefulWidget {
  const KanbanDialoug({super.key});

  @override
  State<KanbanDialoug> createState() => _KanbanDialougState();
}

class _KanbanDialougState extends State<KanbanDialoug> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  DateTime? _selectedDate;
  String _selectedStatus = 'not_started';
  List<dynamic> _selectedImages = [];

  final List<Map<String, dynamic>> statusOptions = [
    {'id': 'not_started', 'text': 'Not Started', 'color': Colors.amber},
    {'id': 'ready', 'text': 'Ready', 'color': Colors.blue},
    {'id': 'in_progress', 'text': 'In Progress', 'color': Colors.orange},
    {'id': 'done', 'text': 'Done', 'color': Colors.green},
    {
      'id': 'blocked',
      'text': 'Blocked',
      'color': const Color.fromARGB(255, 68, 24, 11),
    },
    {
      'id': 'canceled',
      'text': 'Canceled',
      'color': const Color.fromARGB(255, 77, 78, 77),
    },
  ];

  List<String> availableImages = [
    'assets/p1.png',
    'assets/p2.png',
    'assets/p3.png',
    'assets/p8.jpg',
  ];

  @override
  void initState() {
    super.initState();
    // Select random number of images (1-3) when dialog opens
    _selectRandomImages();
  }

  _selectRandomImages() {
    final random = Random();
    final numberOfImages = random.nextInt(3) + 1;

    // Shuffle available images and take required number
    final shuffled = List.from(availableImages)..shuffle();
    setState(() {
      _selectedImages = shuffled.take(numberOfImages).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ShadTheme.of(context).colorScheme;
    return ShadDialog(
      // backgroundColor: theme.muted,
      title: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ShadInput(
          controller: _titleController,
          placeholder: Text(" Enter task title ... "),
        ),
      ),
      description: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ShadInput(
          controller: _descriptionController,
          placeholder: Text(" Enter task description ..."),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ShadButton(
            backgroundColor: theme.ring,
            hoverBackgroundColor: theme.ring,
            child: Icon(Icons.add, size: 16, color: theme.foreground),
            onPressed: () {
              _addTask(context);
            },
          ),
        ),
        ShadButton(
          backgroundColor: theme.destructive,
          child: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 10,
        children: [
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: statusOptions.map((status) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selectedStatus = status['id'];
                  });
                },
                child: ButtonContainer(
                  text: status['text'],
                  bgColor: status['color'],
                  isSelected: _selectedStatus == status['id'],
                ),
              );
            }).toList(),
          ),

          // CircularImages(),
          _buildImagesSection(),
          Text("Due Date"),
          ShadDatePicker(
            //backgroundColor: Colors.white,
            popoverDecoration: ShadDecoration(color: theme.background),
            selectedDayButtonTextStyle: TextStyle(color: Colors.amber),

            selected: _selectedDate,
            onChanged: (DateTime? date) {
              setState(() {
                _selectedDate = date;
              });
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImagesSection() {
    return Column(
      children: [
        const Text(
          "Assignees",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ..._selectedImages.map((imagePath) {
              return Padding(
                padding: const EdgeInsets.only(right: 8),
                child: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.lightBlueAccent,
                  child: ClipOval(
                    child: Image.asset(
                      imagePath,
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              );
            }).toList(),
            Spacer(),
            ShadButton(
              onPressed: _selectRandomImages,
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.shuffle, size: 16),
                  SizedBox(width: 4),
                  Text("Shuffle"),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _addTask(BuildContext context) {
    if (_titleController.text.isEmpty) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Please enter a title')));
      return;
    }

    final newTask = kanbanTask(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: _titleController.text,
      description: _descriptionController.text,
      images: _selectedImages, //['assets/p1.png'], // Default image
      tag: _getStatusText(_selectedStatus),
      comments: 9,
      attachments: 0,
      dueDate: _selectedDate,
      //status: '',
    );

    context.read<KanbanBloc>().add(
      AddTaskEvent(task: newTask, columnId: _selectedStatus),
    );

    Navigator.pop(context);
  }

  String _getStatusText(String statusId) {
    return statusOptions.firstWhere(
      (status) => status['id'] == statusId,
      orElse: () => statusOptions[0],
    )['text'];
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
