import 'package:flutter/material.dart';

import '../constants.dart';

class BackDesign extends StatelessWidget {
  const BackDesign({
    Key? key,
    required this.child,
    required this.ratioHeight,
  }) : super(key: key);
  final Widget? child;
  final double ratioHeight;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(children: [
      Hero(
        tag: 'color box',
        child: Container(
          height: size.height * ratioHeight,
          width: size.width,
          alignment: Alignment.center,
          decoration: const BoxDecoration(
            color: kPrimaryThemeColor1, //TODO: impl dark mode,
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                kPrimaryThemeColor1,
                kPrimaryThemeColor2,
              ],
            ),
            borderRadius: BorderRadius.vertical(
              top: Radius.circular(50),
            ),
          ),
          // child: child,
        ),
      ),
      if (child != null)
        SizedBox(
          height: size.height * ratioHeight,
          child: child!,
        )
    ]);
  }
}
