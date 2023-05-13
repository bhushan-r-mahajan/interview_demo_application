import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:interview_demo_application/components/alert_dialog.dart';
import 'package:interview_demo_application/controllers/todo.dart';
import 'package:interview_demo_application/helpers/textstyles.dart';
import 'package:interview_demo_application/models/todo.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
      padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
      child: Scaffold(
        body: StreamBuilder<List<Task>>(
          stream: todoController.fetchTasks(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text(
                  AppLocalizations.of(context)!.taskLoadingError,
                  style: TextStyles.defaultBoldTextStyle,
                ),
              );
            } else if (snapshot.hasData) {
              final tasks = snapshot.data;
              return tasks!.isEmpty
                  ? Center(
                      child: Text(
                        AppLocalizations.of(context)!.noTasks,
                        style: TextStyles.defaultBoldTextStyle,
                      ),
                    )
                  : ListView(
                      children: tasks
                          .map(
                            (task) => Padding(
                              padding: const EdgeInsets.only(bottom: 5),
                              child:
                                  _makeTaskTileSlidable(task, todoController),
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

  Widget _makeTaskTileSlidable(Task task, TodoController todoController) {
    return Slidable(
      key: ValueKey(task.id),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (context) async {
              await showDialog(
                context: context,
                builder: (context) => CommonAlertDialog(
                  title: AppLocalizations.of(context)!.delete,
                  content: AppLocalizations.of(context)!.deleteMessage,
                  onPressedOk: () async {
                    await todoController.deleteTaskById(task.id);
                    if (mounted) {
                      Navigator.pop(context);
                    }
                  },
                ),
              );
            },
            backgroundColor: Colors.red.shade600,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: AppLocalizations.of(context)!.delete,
          ),
        ],
      ),
      child: _buildTaskTile(task),
    );
  }

  Widget _buildTaskTile(Task task) {
    return InkWell(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddTaskScreen(
            task: task,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey.shade400,
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              task.title,
              style: TextStyles.defaultBoldTextStyle,
            ),
            Text(
              DateFormat('dd/MM/yyyy, h:mm a').format(
                DateTime.parse(task.dateTime),
              ),
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
