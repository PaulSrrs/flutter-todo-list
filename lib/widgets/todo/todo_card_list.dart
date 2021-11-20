import 'package:doing/constants/colors.dart';
import 'package:doing/models/todo.model.dart';
import 'package:doing/routes/routes.dart';
import 'package:doing/services/play_sound.service.dart';
import 'package:doing/services/todo.service.dart';
import 'package:doing/widgets/dialog/dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TodoList extends StatelessWidget {
  const TodoList(this.items, this.collection, {Key? key}) : super(key: key);
  final Map<String, Todo> items;
  final String collection;

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, TodoService todoService, child) {
      return items.keys.isNotEmpty ? ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: items.keys.length,
              itemBuilder: (context, index) {
                final key = items.keys.elementAt(index);
                final item = items[key]!;
                return Card(
                    child: Padding(
                      padding: EdgeInsets.all(Theme.of(context).iconTheme.size! * 0.25),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Checkbox(
                              onChanged: (bool? _) {
                                if (collection == TodoService.remaining) {
                                  todoService.setToDone(item.id);
                                  Provider.of<AppSoundPlayer>(context, listen: false)
                                      .playSound(AppSoundPlayer.taskDoneSoundURI);
                                } else {
                                  todoService.setToRemaining(item.id);
                                  Provider.of<AppSoundPlayer>(context, listen: false)
                                      .playSound(AppSoundPlayer.taskRetrieveSoundURI);
                                }
                              },
                              value: item.isDone,
                            ),
                            Flexible(
                              child: Text(
                                  item.title,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context).textTheme.bodyText1
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                IconButton(
                                    iconSize: Theme.of(context).iconTheme.size ?? 24.0,
                                    icon: const Icon(Icons.edit),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                          context, AppRoutes.updateTask,
                                          arguments: {
                                            'item': item,
                                            'collection': collection
                                          });
                                    }),
                                SizedBox(width: Theme.of(context).iconTheme.size! * 0.25),
                                IconButton(
                                    iconSize: Theme.of(context).iconTheme.size!,
                                    icon: const Icon(Icons.delete_forever),
                                    color: AppColors.warning,
                                    onPressed: () {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return AppDialog(
                                                title: "Delete a task",
                                                content: "Are you sure you want to delete this task ?",
                                                cancelText: "No",
                                                confirmText: "Yes",
                                                confirmCallback: () {
                                                  todoService.delete(collection, item.id);
                                                  Provider.of<AppSoundPlayer>(context, listen: false)
                                                      .playSound(AppSoundPlayer.taskDeletedSoundURI);
                                                  Navigator.pop(context);
                                                },
                                                confirmBtnEnableFeedback: false,
                                                cancelCallback: () => Navigator.pop(context)
                                            );
                                          });
                                    }),
                              ],
                            )
                          ]),
                    ),
                );
              })
          : Align(
              alignment: Alignment.centerLeft,
              child: (collection == TodoService.remaining
                  ? Text("You don't have any tasks yet, to add some, you can click on the white cross at the top right of your screen.",
                  style: Theme.of(context).textTheme.bodyText1)
                  : Text("No tasks have been finished.",
                  style: Theme.of(context).textTheme.bodyText1))
      );
    });
  }
}