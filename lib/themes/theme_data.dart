import 'package:doing/constants/colors.dart';
import 'package:doing/services/is_phone_or_tablet.service.dart';
import 'package:flutter/material.dart';

class AppThemeData {
  static ThemeData getTheme(Brightness brightness) {
    var isPhoneOrTablet = IsPhoneOrTabletService.getDeviceType();

    if (isPhoneOrTablet == DeviceType.tablet) {
      return ThemeData(
          brightness: brightness,
          appBarTheme: AppBarTheme(
            backgroundColor: brightness == Brightness.dark ? AppColors
                .primaryDark : AppColors.primary,
            foregroundColor: Colors.white,
            iconTheme: const IconThemeData(
                size: 32.0,
                color: Colors.white
            ),
            actionsIconTheme: const IconThemeData(
                size: 32.0,
                color: Colors.white
            ),
          ),
          iconTheme: IconThemeData(
              size: 32.0,
              color: brightness == Brightness.dark ? Colors.white : Colors.black
          ),
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all(AppColors.primaryDark),
          ),
          switchTheme: SwitchThemeData(
              thumbColor: MaterialStateProperty.all(AppColors.primaryDark),
              overlayColor: MaterialStateProperty.all(AppColors.primaryDark),
              trackColor: MaterialStateProperty.all(AppColors.primaryDark)
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            alignLabelWithHint: true,
            filled: true,
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 40.0,
              letterSpacing: -0.5,
              fontWeight: FontWeight.w400,
            ),
            headline2: TextStyle(
              fontSize: 36.0,
              letterSpacing: -0.25,
              fontWeight: FontWeight.w400,
            ),
            headline3: TextStyle(
              fontSize: 32.0,
              letterSpacing: 0,
              fontWeight: FontWeight.w400,
            ),
            bodyText1: TextStyle(
              fontSize: 24.0,
              letterSpacing: 0,
              fontWeight: FontWeight.w300,
            ),
            bodyText2: TextStyle(
              fontSize: 20.0,
              letterSpacing: 0,
              fontWeight: FontWeight.w300,
            ),
            button: TextStyle(
              fontSize: 18.0,
              letterSpacing: 0.75,
              fontWeight: FontWeight.w700,
            ),
          )
      );
    } else {
      return ThemeData(
          brightness: brightness,
          appBarTheme: AppBarTheme(
            backgroundColor: brightness == Brightness.dark ? AppColors
                .primaryDark : AppColors.primary,
            foregroundColor: Colors.white,
            iconTheme: const IconThemeData(
                size: 24.0,
                color: Colors.white
            ),
            actionsIconTheme: const IconThemeData(
                size: 24.0,
                color: Colors.white
            ),
          ),
          iconTheme: IconThemeData(
              size: 24.0,
              color: brightness == Brightness.dark ? Colors.white : Colors.black
          ),
          checkboxTheme: CheckboxThemeData(
            fillColor: MaterialStateProperty.all(brightness == Brightness.dark
                ? AppColors.primaryDark
                : AppColors.primary),
          ),
          switchTheme: SwitchThemeData(
            thumbColor: MaterialStateProperty.all(brightness == Brightness.dark
                ? AppColors.primaryDark
                : AppColors.primary),
            trackColor: MaterialStateProperty.all(
                brightness == Brightness.dark ? AppColors.primary : AppColors
                    .primaryLight),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            border: OutlineInputBorder(),
            alignLabelWithHint: true,
            filled: true,
          ),
          textTheme: const TextTheme(
            headline1: TextStyle(
              fontSize: 24.0,
              letterSpacing: -0.25,
              fontWeight: FontWeight.w400,
            ),
            headline2: TextStyle(
              fontSize: 20.0,
              letterSpacing: 0,
              fontWeight: FontWeight.w400,
            ),
            headline3: TextStyle(
              fontSize: 18.0,
              letterSpacing: 0,
              fontWeight: FontWeight.w400,
            ),
            bodyText1: TextStyle(
              fontSize: 16.0,
              letterSpacing: 0,
              fontWeight: FontWeight.w300,
            ),
            bodyText2: TextStyle(
              fontSize: 14.0,
              letterSpacing: 0,
              fontWeight: FontWeight.w300,
            ),
            button: TextStyle(
              fontSize: 14.0,
              letterSpacing: 0.75,
              fontWeight: FontWeight.w700,
            ),
          )
      );
    }
  }
}