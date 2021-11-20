import 'package:flutter/material.dart';

class AppColors {
  // add a private constructor to prevent this class being instantiated
  // e.g. invoke `LocalStorageKey()` accidentally
  AppColors._();

  // the properties are static so that we can use them without a class instance
  // e.g. can be retrieved by `LocalStorageKey.saveUserId`.
  static const primary =  Color(0xFF2196F3);
  static const primaryDark =  Color(0xFF005396);
  static const primaryLight =  Color(0xFFB6DFFF);
  static const greyDark = Color(0xFF707D87);
  static const warning =  Color(0xFFBB1F1F);
  static const success =  Color(0xFF53A653);
}