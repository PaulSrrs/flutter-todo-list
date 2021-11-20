import 'package:doing/constants/colors.dart';
import 'package:doing/services/play_sound.service.dart';
import 'package:doing/services/todo.service.dart';
import 'package:doing/widgets/dialog/dialog.dart';
import 'package:doing/widgets/switch/switch.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doing/services/shared_preferences.service.dart';
import 'package:doing/routes/routes.dart';
import 'package:doing/services/theme_model.service.dart';

/// StatelessWidget used to display every settings like darkmode
class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  /// builder
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Settings")),
      body: Container(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Text("Dark mode :", style: Theme.of(context).textTheme.bodyText1),
                const SizedBox(width: 24),
                Consumer(builder: (context, ThemeModelService themeNotifier, child) {
                  return AppSwitch(
                    onChanged: () async {
                      if (themeNotifier.isDark) {
                        themeNotifier.setTheme(false);
                        Provider.of<AppSoundPlayer>(context, listen: false)
                            .playSound(AppSoundPlayer.disableSoundURI);
                      } else {
                        themeNotifier.setTheme(true);
                        Provider.of<AppSoundPlayer>(context, listen: false)
                            .playSound(AppSoundPlayer.enableSoundURI);
                      }
                    },
                    value: themeNotifier.isDark,
                  );
                })
              ]),
              const SizedBox(height: 32),
              Consumer(builder: (context, TodoService todoService, child) {
                return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AppDialog(
                                  title: "Delete all tasks",
                                  content: "Are you sure you want to delete all your tasks ?",
                                  cancelText: "No",
                                  confirmText: "Yes",
                                  confirmCallback: () {
                                    todoService.deleteAll();
                                    Navigator.pop(context);
                                  },
                                  cancelCallback: () => Navigator.pop(context)
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.warning,
                        ),
                        child: const Text('Delete all tasks'),
                      ),
                      const SizedBox(height: 12),
                      ElevatedButton(
                        onPressed: () async {
                          showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AppDialog(
                                    title: "Delete personal information",
                                    content: "Are you sure you want to delete your personal information ?\nAll your tasks will also be deleted.",
                                    cancelText: "No",
                                    confirmText: "Yes",
                                    confirmCallback: () {
                                      todoService.deleteAll();
                                      SharedPreferencesService()
                                          .clearData();
                                      Navigator.pushNamedAndRemoveUntil(context, AppRoutes.stepper, (r) => false);
                                    },
                                    cancelCallback: () => Navigator.pop(context)
                                );
                              });
                        },
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.warning,
                        ),
                        child: const Text('Delete personal information'),
                      )
                    ]);
              }),
            ],
          )),
    );
  }
}
