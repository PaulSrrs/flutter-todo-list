import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSwitch extends StatelessWidget {
  const AppSwitch({required this.onChanged, required this.value, Key? key}) : super(key: key);
  final VoidCallback onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ?
    Switch(
      onChanged: (_) async {
        onChanged();
      },
      value: value,
    ) : CupertinoSwitch(
      onChanged: (_) async {
        onChanged();
      },
      value: value
    );
  }
}
