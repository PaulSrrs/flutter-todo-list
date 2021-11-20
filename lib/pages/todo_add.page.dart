import 'package:doing/services/todo.service.dart';
import 'package:doing/widgets/buttons/safe_area_button.dart';
import 'package:doing/widgets/inputs/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doing/constants/colors.dart';
import 'package:provider/provider.dart';

class TodoAddPage extends StatelessWidget {
  TodoAddPage({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.success,
        appBar: AppBar(title: const Text("Add a task")),
        body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const SizedBox(height: 24),
                        AppInput(
                          controller: titleController,
                          placeholder: 'Title *',
                          textCapitalization: TextCapitalization.sentences,
                          errorMessage: "Please enter a title for the task",
                        ),
                        const SizedBox(height: 24),
                        AppInput(
                            controller: descriptionController,
                            placeholder: 'Description',
                            textCapitalization: TextCapitalization.sentences,
                            maxLines: 6
                        ),
                      ],
                    )
                )
            )
        ),
        bottomNavigationBar: Consumer(
            builder: (context, TodoService todoService, child) {
              return AppSafeAreaButton(
                  text: "Add the task",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await todoService.add(TodoService.remaining,
                          titleController.text, descriptionController.text);
                      Navigator.pop(context);
                    }
                  });
            })
    );
  }
}
