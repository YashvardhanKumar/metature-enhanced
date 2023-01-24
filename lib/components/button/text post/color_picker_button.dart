import 'package:flutter/material.dart';

class ColorPickerButton extends StatelessWidget {
  const ColorPickerButton({
    Key? key,
    required this.color,
    required this.onClick,
  }) : super(key: key);
  final Color color;
  final ValueChanged<Color> onClick;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onClick(color),
      child: Container(
        height: 20,
        width: 20,
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color,
        ),
      ),
    );
  }
}