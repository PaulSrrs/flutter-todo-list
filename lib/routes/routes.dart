import 'package:doing/pages/team_member.page.dart';
import 'package:flutter/material.dart';
import 'package:doing/pages/our_team.page.dart';
import 'package:doing/pages/profile.page.dart';
import 'package:doing/pages/todo_add.page.dart';
import 'package:doing/pages/todo.page.dart';
import 'package:doing/pages/todo_update.page.dart';
import 'package:doing/pages/stepper.page.dart';
import 'package:doing/pages/settings.page.dart';

class AppRoutes {
  static const String stepper = '/stepper';
  static const String home = '/task';
  static const String addTask = '/task/add';
  static const String updateTask = '/task/update';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String ourTeam = '/our-team';
  static const String ourTeamMember = '/our-team/member';
}

var appRoutes = <String, WidgetBuilder> {
  AppRoutes.stepper: (context) => const StepperPage(),             //stepper page, where the user can set his information
  AppRoutes.home: (context) => const TodoMainPage(),                    //home page, the todo list screen
  AppRoutes.addTask: (context) => TodoAddPage(),                 //add page, where the user can add a task
  AppRoutes.updateTask: (context) => const TodoUpdatePage(),          //modify page, where the user can modify one of his task or delete it
  AppRoutes.profile: (context) => const ProfilePage(),             //profile page, where the user can see or modify his information
  AppRoutes.settings: (context) => const SettingsPage(),            //settings page, where the user can change language, enable dark mode or delete his tasks or his personals information
  AppRoutes.ourTeam: (context) => const OurTeamPage(),
  AppRoutes.ourTeamMember: (context) => const TeamMemberPage(),
  //our-team page, where the user can see a list of app's developers (us)
};