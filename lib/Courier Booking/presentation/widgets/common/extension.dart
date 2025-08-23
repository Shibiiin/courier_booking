import 'package:flutter/material.dart';

extension SizedBoxSpacingExtension on num {
  Widget get height => SizedBox(height: toDouble());
  Widget get width => SizedBox(width: toDouble());
}

extension MediaQuerryExtension on BuildContext {
  double mediaQueryWidth() => MediaQuery.sizeOf(this).width;
  double mediaQueryHeight() => MediaQuery.sizeOf(this).height;
}
