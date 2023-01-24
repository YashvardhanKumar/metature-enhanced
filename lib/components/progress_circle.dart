import 'package:flutter/material.dart';

import '../constants.dart';

class ProgressCircle extends StatelessWidget {
  final double? value;

  const ProgressCircle({
    Key? key,
    this.color,
    this.height,
    this.value,
  }) : super(key: key);
  final double? height;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: height,
        width: height,
        padding: EdgeInsets.all(8.0),
        child: CircularProgressIndicator(
          value: value,
          strokeWidth: 1,
          color: color ?? kSecondaryThemeColor1,
        ),
      ),
    );
  }
}
