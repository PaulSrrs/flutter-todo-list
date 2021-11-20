import 'package:doing/services/todo.service.dart';
import 'package:doing/widgets/todo/todo_card_list.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:doing/routes/routes.dart';
import 'package:doing/widgets/drawer/drawer.dart';
import 'package:flutter/scheduler.dart';
import 'package:provider/provider.dart';

class TodoMainPage extends StatefulWidget {
  const TodoMainPage({Key? key}) : super(key: key);

  @override
  TodoMainPageState createState() => TodoMainPageState();
}

class TodoMainPageState extends State<TodoMainPage> {
  static const appTitle = 'Doing';
  bool tasksFetchedFromCache = false;

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance?.addPostFrameCallback((_) => {
        setState(() {
          tasksFetchedFromCache = true;
        })
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
              appTitle,
          ),
          actions: <Widget>[
            IconButton(
                onPressed: () => Navigator.pushNamed(context, AppRoutes.addTask),
                icon: Icon(
                  Icons.add,
                  size: Theme.of(context).appBarTheme.actionsIconTheme!.size
                )
            ),
          ],
        ),
        drawer: const AppDrawer(),
        body: Consumer(builder: (context, TodoService todoService, child) {
          return Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
            child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
                child: Column(
                  children: [
                    titleTodoPage(context, "Remaining tasks"),
                    const SizedBox(height: 8),
                    TodoList(todoService.remainingTodo, TodoService.remaining),
                    const SizedBox(height: 24),
                    titleTodoPage(context, "Tasks done"),
                    const SizedBox(height: 8),
                    TodoList(todoService.doneTodo, TodoService.done),
                    const SizedBox(height: 16),
                  ],
                )
            ),
          );
        })
    );
  }

  Widget titleTodoPage(BuildContext context, String title) {
    return Align(
      alignment: Alignment.centerLeft,
        child: FittedBox(
          fit: BoxFit.cover,
          child: Text(title, style: Theme.of(context).textTheme.headline1))
    );
  }
}
