import 'package:doing/constants/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppSafeAreaButton extends StatelessWidget {
  const AppSafeAreaButton({
    required this.onPressed,
    required this.text,
    Key? key
  }) : super(key: key);

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        bottom: true,
        child: MaterialButton(
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
            highlightElevation: 0.0,
            elevation: 0.0,
            color: AppColors.success,
            child: Text(text, style: Theme.of(context).textTheme.button!.copyWith(
              color: Colors.white
            )),
            onPressed: onPressed
        )
    );
  }
}
