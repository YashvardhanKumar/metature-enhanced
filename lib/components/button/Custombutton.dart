// ignore: file_names
import 'package:flutter/material.dart';

import '../../constants.dart';

class CustomButton extends StatefulWidget {
  CustomButton({
    Key? key,
    this.height,
    this.width,
    required this.child,
    required this.onPressed,
    this.colorString,
    this.addBoxShadow = true,
  }) : super(key: key);
  final double? height, width;
  final Widget? child;
  final VoidCallback? onPressed;
  final int? colorString;
  bool addBoxShadow;

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isTapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (widget.onPressed != null) {
          widget.onPressed!();
        }
        setState(() {
          isTapped = true;
        });
      },
      child: AnimatedContainer(
        onEnd: (() => setState(() => isTapped = false)),
        margin: EdgeInsets.symmetric(
          vertical: isTapped ? 9 : 7,
          horizontal: isTapped ? 19 : 15,
        ),
        height: (isTapped) ? (widget.height ?? 45) - 4 : (widget.height ?? 45),
        width: (isTapped) ? (widget.width ?? 125) - 8 : (widget.width ?? 125),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(isTapped ? 11 : 12)),
            boxShadow: widget.addBoxShadow
                ? [
                    BoxShadow(
                        offset: const Offset(2, 2),
                        spreadRadius: (isTapped) ? 0 : 2,
                        blurRadius: (isTapped) ? 5 : 8,
                        color: Color(
                            (widget.colorString ?? kPrimaryThemeColor4.value) +
                                0x0037391E)),
                    BoxShadow(
                        offset: const Offset(-2, -2),
                        spreadRadius: (isTapped) ? 0 : 2,
                        blurRadius: (isTapped) ? 5 : 8,
                        color: Color(
                            (widget.colorString ?? kPrimaryThemeColor4.value) +
                                0x007C6A4B)),
                  ]
                : null,
            gradient: widget.onPressed == null
                ? null
                : LinearGradient(
                    begin:
                        (isTapped) ? Alignment.bottomLeft : Alignment.topLeft,
                    end:
                        (isTapped) ? Alignment.topRight : Alignment.bottomRight,
                    colors: [
                        Color(
                            (widget.colorString ?? kPrimaryThemeColor4.value) +
                                0x0037391E),
                        Color(widget.colorString ?? kPrimaryThemeColor4.value),
                      ]),
            color: widget.onPressed == null ? Colors.grey : null),
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubicEmphasized,
        child: widget.child,
      ),
    );
  }
}
