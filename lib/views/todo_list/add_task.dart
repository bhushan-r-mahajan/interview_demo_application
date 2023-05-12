import 'package:flutter/material.dart';
import 'package:interview_demo_application/controllers/todo.dart';
import 'package:interview_demo_application/helpers/textstyles.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../models/todo.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, this.task});

  final Task? task;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formkey = GlobalKey<FormState>();
  DateTime? dateTime;
  String title = "";
  String description = "";
  bool invalidDateTime = false;
  bool isEditing = false;

  @override
  void initState() {
    super.initState();
    checkIsEditing();
  }

  void checkIsEditing() {
    if (widget.task != null) {
      setState(() {
        title = widget.task!.title;
        description = widget.task!.description!;
        dateTime = DateTime.parse(widget.task!.dateTime);
        isEditing = true;
      });
    }
  }

  Future<DateTime?> pickDate() => showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(2100),
      );

  @override
  Widget build(BuildContext context) {
    var todoController = Provider.of<TodoController>(context);
    return SafeArea(
      child: GestureDetector(
        onTap: () {
          FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text(
              "Add Task",
              style: TextStyles.defaultBoldTextStyle,
            ),
          ),
          body: todoController.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          initialValue: title,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "Title can't be empty";
                            }
                            return null;
                          },
                          onSaved: (value) => title = value!,
                          decoration: const InputDecoration(
                            hintText: "Title",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 30),
                        TextFormField(
                          initialValue: description,
                          onSaved: (value) => description = value!,
                          decoration: const InputDecoration(
                            hintText: "Description",
                            border: OutlineInputBorder(),
                          ),
                        ),
                        const SizedBox(height: 30),
                        _buildDateSelectorContainer(),
                        const SizedBox(height: 30),
                        _buildButtonsRow(todoController),
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildDateSelectorContainer() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        InkWell(
          onTap: () async {
            final date = await pickDate();
            if (date == null) return;
            setState(() {
              dateTime = date;
            });
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: invalidDateTime
                    ? Colors.red.shade700
                    : Colors.grey.shade500,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            padding:
                const EdgeInsets.only(top: 15, bottom: 15, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  dateTime != null
                      ? DateFormat('EEEE, MMM d, yyyy').format(dateTime!)
                      : "Select a date",
                  style: TextStyles.defaultTextStyle,
                ),
                const Icon(Icons.calendar_month)
              ],
            ),
          ),
        ),
        invalidDateTime
            ? Padding(
                padding: const EdgeInsets.only(top: 6, left: 11),
                child: Text(
                  "Date can't be empty",
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    color: Colors.red.shade700,
                  ),
                ),
              )
            : const SizedBox(),
      ],
    );
  }

  Widget _buildButtonsRow(TodoController todoController) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              setState(() => invalidDateTime = false);
              if (!_formkey.currentState!.validate()) {
                if (dateTime == null) {
                  setState(() => invalidDateTime = true);
                  return;
                }
                return;
              }
              _formkey.currentState!.save();
              if (isEditing) {
                await todoController.updateTask(
                  id: widget.task!.id,
                  title: title,
                  description: description,
                  dateTime: '$dateTime',
                );
              } else {
                await todoController.addTask(title, description, '$dateTime');
              }

              if (mounted) {
                Navigator.pop(context);
              }
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Save",
                style: TextStyles.defaultTextStyle,
              ),
            ),
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: ElevatedButton(
            onPressed: () {
              _formkey.currentState!.reset();
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(vertical: 15),
              child: Text(
                "Clear",
                style: TextStyles.defaultTextStyle,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
