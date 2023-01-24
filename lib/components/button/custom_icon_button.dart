import 'package:flutter/material.dart';
import 'package:metature2/constants.dart';

class CustomIconButton extends StatelessWidget {
  const CustomIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
    this.selected = false,
  }) : super(key: key);
  final VoidCallback? onPressed;
  final Icon icon;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: (selected) ? kPrimaryThemeColor1 : Colors.white54,
      type: MaterialType.canvas,
      shape: const CircleBorder(),
      clipBehavior: Clip.hardEdge,
      child: IconButton(
        onPressed: onPressed,
        icon: icon,
      ),
    );
  }
}
