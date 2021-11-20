import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// The DismissKeyboard widget (it's reusable)
class DismissKeyboard extends StatelessWidget {
  const DismissKeyboard({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null &&
            FocusManager.instance.primaryFocus != null) {
          FocusManager.instance.primaryFocus!.unfocus();
        }
      },
      child: child,
    );
  }
}