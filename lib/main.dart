import 'package:doing/services/play_sound.service.dart';
import 'package:doing/services/shared_preferences.service.dart';
import 'package:doing/services/todo.service.dart';
import 'package:doing/themes/theme_data.dart';
import 'package:doing/widgets/keyboard/dismiss_keyboard.dart';
import 'package:flutter/material.dart';
import 'package:doing/constants/shared_preferences.dart';
import 'package:provider/provider.dart';
import 'package:doing/routes/routes.dart';
import 'models/todo.model.dart';
import 'services/theme_model.service.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Map<String, Todo> _remainingTodos = TodoService.getTodosFromCollection(TodoService.remaining);
  Map<String, Todo> _doneTodos = TodoService.getTodosFromCollection(TodoService.done);
  bool? isDark = await ThemeModelService.getTheme();
  bool imageExistInCache = await SharedPreferencesService().containsKey(AppSharedPreferences.profileImage);
  if (imageExistInCache) {
    runApp(DoingApplication(AppRoutes.home, isDark ?? false, _remainingTodos, _doneTodos));
  } else {
    runApp(DoingApplication(AppRoutes.stepper, isDark ?? false, _remainingTodos, _doneTodos));
  }
}

class DoingApplication extends StatefulWidget {
  const DoingApplication(
      this.initialRoute,
      this.isDark,
      this.remainingTodos,
      this.doneTodos,
      {Key? key}
  ) : super(key: key);

  final String initialRoute;
  final bool isDark;
  final Map<String, Todo> remainingTodos;
  final Map<String, Todo> doneTodos;

  @override
  DoingApplicationState createState() {
    return DoingApplicationState();
  }
}

class DoingApplicationState extends State<DoingApplication> {
  static const _appTitle = 'Doing';
  final AppSoundPlayer appSoundPlayer = AppSoundPlayer();

  @override
  void initState() {
    super.initState();
    appSoundPlayer.init();
  }

  @override
  void dispose() {
    appSoundPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeModelService(widget.isDark)),
        ChangeNotifierProvider(create: (_) => TodoService(widget.remainingTodos, widget.doneTodos)),
        Provider(create: (_) => appSoundPlayer),
      ],
      child: Consumer(builder: (context, ThemeModelService themeModelService, child) {
        return DismissKeyboard(
            child: MaterialApp(
          theme: AppThemeData.getTheme(Brightness.light),
          darkTheme: AppThemeData.getTheme(Brightness.dark),
          themeMode: themeModelService.isDark ? ThemeMode.dark : ThemeMode.light,
          debugShowCheckedModeBanner: false,
          title: _appTitle,
          initialRoute: widget.initialRoute,
          routes: appRoutes,
        ));
      }),
    );
  }
}
