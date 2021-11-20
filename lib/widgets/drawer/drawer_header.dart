import 'dart:io';
import 'package:doing/services/shared_preferences.service.dart';
import 'package:flutter/material.dart';
import 'package:doing/constants/colors.dart';
import 'package:doing/routes/routes.dart';
import 'package:doing/constants/shared_preferences.dart';

class AppDrawerHeader extends StatefulWidget {
  const AppDrawerHeader({Key? key}) : super(key: key);

  @override
  _AppDrawerHeaderState createState() => _AppDrawerHeaderState();
}

class _AppDrawerHeaderState extends State<AppDrawerHeader> {
  File? _image;
  String? _firstname;
  String? _lastname;
  String? _age;
  String? _job;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  void loadData() async {
    String? imagePath = await SharedPreferencesService()
        .getString(AppSharedPreferences.profileImage);
    String _firstnamePath = await SharedPreferencesService()
            .getString(AppSharedPreferences.firstname) ?? '';
    String _lastnamePath = await SharedPreferencesService()
            .getString(AppSharedPreferences.lastname) ?? '';
    String _agePath = await SharedPreferencesService()
        .getString(AppSharedPreferences.age) ?? '';
    String _jobPath = await SharedPreferencesService()
        .getString(AppSharedPreferences.job) ?? '';

    setState(() {
      if (imagePath != null) {
        _image = File(imagePath);
      }
      _firstname = _firstnamePath;
      _lastname = _lastnamePath;
      _age = _agePath;
      _job = _jobPath;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 0),
      padding: const EdgeInsets.fromLTRB(16.0, 48.0, 16.0, 48.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InkWell(
              onTap: () {
                Navigator.pop(context);
                Navigator.pushNamed(context, AppRoutes.profile);
              },
              child: CircleAvatar(
                  radius: 55,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: _image != null
                          ? Image.file(
                        _image!,
                              width: 100,
                              height: 100,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              width: 100,
                              height: 100,
                              color: AppColors.primary,
                            )
                  )
              )
          ),
          const SizedBox(height: 32),
          Text(_firstname ?? '',
              style: Theme.of(context).textTheme.headline3,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 8),
          Text(_lastname ?? '',
              style: Theme.of(context).textTheme.headline3,
              overflow: TextOverflow.ellipsis),
          const SizedBox(height: 32),
          Text(_age != null ? "$_age years old" : '',
                style: Theme.of(context).textTheme.bodyText1,
                overflow: TextOverflow.ellipsis),
          const SizedBox(height: 8),
          Text(_job ?? '',
              style: Theme.of(context).textTheme.bodyText1,
              overflow: TextOverflow.ellipsis),
        ],
      ),
    );
  }
}
