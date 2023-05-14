import 'package:flutter/material.dart';
import 'package:interview_demo_application/controllers/todo.dart';
import 'package:interview_demo_application/helpers/textstyles.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../../components/appbar.dart';
import '../../components/button.dart';
import '../../models/todo.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key, this.task});
  final Task? task;

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _formkey = GlobalKey<FormState>();
  final titleController = TextEditingController();
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

  @override
  void dispose() {
    titleController.dispose();
    super.dispose();
  }

  void checkIsEditing() {
    if (widget.task != null) {
      setState(() {
        titleController.text = widget.task!.title;
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
          appBar: CommonAppBar.appBar(
            AppLocalizations.of(context)!.addTask,
          ),
          body: todoController.isLoading
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Form(
                    key: _formkey,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: titleController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return AppLocalizations.of(context)!
                                  .emptyTaskNameMessage;
                            }
                            return null;
                          },
                          onSaved: (value) => title = value!,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context)!.taskName,
                            border: const OutlineInputBorder(),
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
                      ? DateFormat('dd/MM/yyyy, h:mm a').format(dateTime!)
                      : AppLocalizations.of(context)!.dateAndTime,
                  style: TextStyles.defaultTextStyle,
                ),
                const Icon(
                  Icons.calendar_month,
                  color: Colors.white,
                )
              ],
            ),
          ),
        ),
        invalidDateTime
            ? Padding(
                padding: const EdgeInsets.only(top: 6, left: 11),
                child: Text(
                  AppLocalizations.of(context)!.emptyDateMessage,
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
          child: CommonButton(
            onPressed: () async => validateForm(todoController),
            buttonText: AppLocalizations.of(context)!.save,
          ),
        ),
        const SizedBox(width: 30),
        Expanded(
          child: CommonButton(
            onPressed: () => setState(
              () {
                _formkey.currentState!.reset();
                titleController.clear();
                dateTime = null;
              },
            ),
            buttonText: AppLocalizations.of(context)!.clear,
          ),
        ),
      ],
    );
  }

  void validateForm(TodoController todoController) async {
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
  }
}
