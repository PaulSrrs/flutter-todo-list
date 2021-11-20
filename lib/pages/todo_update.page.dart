import 'package:doing/constants/colors.dart';
import 'package:doing/models/todo.model.dart';
import 'package:doing/services/todo.service.dart';
import 'package:doing/widgets/buttons/safe_area_button.dart';
import 'package:doing/widgets/inputs/text_input.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoUpdatePage extends StatefulWidget {
  const TodoUpdatePage({Key? key}) : super(key: key);

  @override
  TodoUpdatePageState createState() {
    return TodoUpdatePageState();
  }
}

class TodoUpdatePageState extends State<TodoUpdatePage> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  Todo? item;
  String? collection;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance?.addPostFrameCallback((_) async {
      Map? data = ModalRoute.of(context)!.settings.arguments as Map?;
      item = data?['item'];
      collection = data?['collection'];
      if (item != null) {
        titleController.text = item?.title ?? '';
        descriptionController.text = item?.description ?? '';
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.success,
        appBar: AppBar(
          title: const Text('Update a task'),
        ),
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
                    )))),
        bottomNavigationBar: Consumer(
            builder: (context, TodoService todoService, child) {
              return AppSafeAreaButton(
                  text: "Update the task",
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      await todoService.update(
                          collection!,
                          item!.id,
                          titleController.text,
                          descriptionController.text);
                      Navigator.pop(context);
                    }
                  });
            })
    );
  }
}
