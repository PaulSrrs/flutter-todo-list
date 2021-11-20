import 'package:flutter/widgets.dart';

enum DeviceType {
  phone,
  tablet
}

class IsPhoneOrTabletService {
  static DeviceType getDeviceType() {
    final data = MediaQueryData.fromWindow(WidgetsBinding.instance!.window);
    return data.size.shortestSide < 550 ? DeviceType.phone : DeviceType.tablet;
  }
}