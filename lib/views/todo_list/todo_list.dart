import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:interview_demo_application/controllers/todo.dart';
import 'package:interview_demo_application/helpers/textstyles.dart';
import 'package:interview_demo_application/models/todo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'add_task.dart';

class ToDoListScreen extends StatefulWidget {
  const ToDoListScreen({super.key});

  @override
  State<ToDoListScreen> createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  @override
  Widget build(BuildContext context) {
    var todoController = Provider.of<TodoController>(context);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Scaffold(
        body: StreamBuilder<List<Task>>(
          stream: todoController.fetchTasks(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text(
                  "Failed to load tasks.",
                  style: TextStyles.defaultBoldTextStyle,
                ),
              );
            } else if (snapshot.hasData) {
              final tasks = snapshot.data;
              return ListView(
                children: tasks!
                    .map(
                      (task) => Column(
                        children: [
                          buildTaskTile(task, todoController),
                          const Divider(thickness: 2),
                        ],
                      ),
                    )
                    .toList(),
              );
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddTaskScreen(
                  task: null,
                ),
              ),
            );
          },
          child: const Icon(
            Icons.add,
            size: 28,
          ),
        ),
      ),
    );
  }

  Widget buildTaskTile(Task task, TodoController todoController) {
    return Slidable(
      key: ValueKey(task.id),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await todoController.deleteTaskById(task.id);
            },
            backgroundColor: Colors.red.shade600,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        onTap: () async {
          if (mounted) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTaskScreen(task: task),
              ),
            );
          }
        },
        title: Text(
          task.title,
          style: TextStyles.defaultTextStyle,
        ),
        subtitle: Text(
          task.description!,
          style: TextStyles.defaultTextStyle,
        ),
        trailing: Text(
          DateFormat('EEEE, MMM d, yyyy').format(DateTime.parse(task.dateTime)),
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}
