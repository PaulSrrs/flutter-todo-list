import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppDialog extends StatelessWidget {
  const AppDialog({
    required this.title,
    required this.content,
    required this.confirmText,
    required this.cancelText,
    required this.confirmCallback,
    required this.cancelCallback,
    this.confirmBtnEnableFeedback = true,
    Key? key
  }) : super(key: key);

  final String title;
  final String content;
  final String confirmText;
  final bool confirmBtnEnableFeedback;
  final String cancelText;
  final VoidCallback confirmCallback;
  final VoidCallback cancelCallback;

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ?
    AlertDialog(
        title: Text(title),
        content: Text(content),
        actions: <Widget>[
          TextButton(
            child: Text(cancelText),
            onPressed: () {
              cancelCallback();
            },
          ),
          TextButton(
              style: ButtonStyle(enableFeedback: confirmBtnEnableFeedback), //remove default sound on Android
              child: Text(confirmText),
              onPressed: () => confirmCallback()
          )
        ]
    ) : CupertinoAlertDialog(
      title: Text(title),
      content: Text(content),
      actions: <Widget>[
        CupertinoDialogAction(
          child: Text(cancelText),
          onPressed: () => cancelCallback(),
        ),
        CupertinoDialogAction(
          isDefaultAction: true,
          child: Text(confirmText),
          onPressed: () => confirmCallback(),
        ),
      ]
    );
  }
}
