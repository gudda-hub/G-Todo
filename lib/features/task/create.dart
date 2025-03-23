import 'dart:developer';

import '../../export.dart';

class TaskCreateScreen extends ConsumerStatefulWidget {
  const TaskCreateScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _TaskCreateScreenState();
}

class _TaskCreateScreenState extends ConsumerState<TaskCreateScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _selectedDateController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String priority = '';
  String status = '';
  bool isComplete = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(18.0),
            children: [
              TxtField(
                  txtModel: TxtModel(
                      labelText: "Task Title",
                      hintText: "Enter the task title",
                      controller: _titleController,
                      validator: (value) => value == null || value.isEmpty
                          ? "Title is required"
                          : null)),
              heightSizedBox(20),
              TxtField(
                  txtModel: TxtModel(
                      hintText: "Describe your task in detail",
                      maxLines: 8,
                      controller: _descriptionController,
                      validator: (value) => value == null || value.isEmpty
                          ? "Description is required"
                          : null)),
              heightSizedBox(20),
              TxtField(
                  txtModel: TxtModel(
                      labelText: "Select Due Date",
                      hintText: "Select Due Date",
                      controller: _selectedDateController,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      validator: validateField,
                      suffixIcon: const Icon(Icons.calendar_today),
                      readOnly: true,
                      onTap: () async {
                        String getValue = await selectDateTime(context);
                        if (getValue.isNotEmpty) {
                          _selectedDateController.text = getValue;
                        }
                      })),
              heightSizedBox(20),
              DropDownBtn(priority, (value) {
                setState(() {
                  priority = value!;
                });
              }, hintTxt: "Select Priority", itemsList: priorityOptions),
              heightSizedBox(20),
              DropDownBtn(status, (value) {
                setState(() {
                  status = value!;
                });
              }, hintTxt: "Select Status", itemsList: statusOptions),
              heightSizedBox(20),
              DropDownBtn(isComplete ? 'Yes' : 'No', (value) {
                setState(() {
                  isComplete = value == 'Yes' ? true : false;
                });
              }, hintTxt: "Is Completed?", itemsList: isCompletedOptions),
              heightSizedBox(24),
            ],
          ),
        ),
      ),
      bottomSheet: Container(
          margin: const EdgeInsets.all(16),
          width: MediaQuery.of(context).size.width * .85,
          height: 55,
          child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shadowColor: Colors.black,
                  surfaceTintColor: Colors.grey,
                  overlayColor: Colors.blueGrey),
              onPressed: _submitTask,
              child: Text(
                "Add Task",
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold, color: Colors.white70),
              ))),
    );
  }

  void _submitTask() {
    bool isValid = _formKey.currentState!.validate() &&
        priority.isNotEmpty &&
        status.isNotEmpty;
    if (isValid) {
      log("Priority , status , isComplete : $priority , $status , $isComplete");

      final task = TaskModel(
          id: generateUniqueTaskId(),
          title: _titleController.text.trim(),
          description: _descriptionController.text.trim(),
          status: status,
          priority: priority,
          dueDate: DateTime.now(),
          createdDate: DateTime.now(),
          updatedDate: DateTime.now(),
          isCompleted: isComplete);
      log("Create Btn FInal Data :${task.toJson()}");
      ref.watch(apiControllerProvider).create(task);
    } else {
      List messages = [];
      Map<String, dynamic> fieldValidations = {
        "priority": priority.isEmpty,
        "status": status.isEmpty
      };
      fieldValidations.forEach((key, value) {
        if (value) {
          messages.add(key);
        }
      });
      String requiredMsg = messages.join(", ");
      snackBarMsg("$requiredMsg is Required", color: Colors.red);
    }
  }

  @override
  void dispose() {
    _titleController.clear();
    _descriptionController.clear();
    _selectedDateController.clear();
    super.dispose();
  }
}
