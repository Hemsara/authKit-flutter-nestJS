import 'package:gap/gap.dart';

class AppDimens {
  static double baseSize = 8;

  static Gap gap(double? x) => Gap(baseSize * (x ?? 1));
}
