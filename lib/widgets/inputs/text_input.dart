import 'package:doing/controllers/custom_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppInput extends StatelessWidget {
  const AppInput({
    required this.controller,
    required this.placeholder,
    required this.textCapitalization,
    this.errorMessage,
    this.maxLines = 1,
    Key? key
  }) : super(key: key);

  final TextEditingController controller;
  final String placeholder;
  final TextCapitalization textCapitalization;
  final String? errorMessage;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    var deviceWidth = MediaQuery.of(context).size.width;
    return SizedBox(
        width: deviceWidth > 750 ? deviceWidth * 0.4 : deviceWidth,
        child: TextFormField(
            style: Theme.of(context).textTheme.bodyText1,
            controller: controller,
            textCapitalization: textCapitalization,
            decoration: InputDecoration(
              labelText: placeholder
            ),
            validator: (value) => errorMessage != null ? CustomValidator.emptyValidator(
                value, errorMessage!) : null,
            maxLines: maxLines)
    );
  }
}
