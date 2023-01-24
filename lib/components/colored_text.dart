import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metature2/constants.dart';

class NormalText extends StatelessWidget {
  const NormalText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
    this.overflow,
    this.nullWidth,
  });
  final String? text;
  final double? fontSize;
  final Color? color;
  final FontWeight? fontWeight;
  final TextOverflow? overflow;
  final double? nullWidth;

  @override
  Widget build(BuildContext context) {
    if (text == null) {
      return Container(
        decoration: BoxDecoration(
          color: kPrimaryThemeColor2,
          borderRadius: BorderRadius.circular(3),
        ),
        height: fontSize,
        width: nullWidth,
      );
    }
    return Text(
      text!,
      overflow: overflow,
      style: GoogleFonts.poppins(
        fontSize: fontSize,
        color: color ?? kSecondaryThemeColor1,
        fontWeight: fontWeight,
      ),
    );
  }
}
