import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants.dart';

class CustomTextFormField extends StatefulWidget {
  final String? hintText;
  final BorderRadius? borderRadius;
  final Color? color;
  final ValueChanged<String>? onChanged;
  final bool? isPassword;
  final Iterable<String>? autoFillHints;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final TextCapitalization? textCapitalization;
  final String? value;
  final List<TextInputFormatter>? inputFormatter;
  final VoidCallback? onEditingComplete;
  const CustomTextFormField({
    Key? key,
    this.hintText,
    this.borderRadius,
    this.color,
    this.onChanged,
    this.isPassword,
    this.autoFillHints,
    this.validator,
    this.keyboardType,
    this.controller,
    this.textCapitalization, this.value, this.inputFormatter, this.onEditingComplete,
  }) : super(key: key);

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
      decoration: BoxDecoration(
        color: kSecondaryThemeColor4,
        borderRadius: widget.borderRadius ?? BorderRadius.zero,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              inputFormatters: widget.inputFormatter,
              initialValue: widget.value,
              textCapitalization: widget.textCapitalization ??
                  TextCapitalization.none,
              controller: widget.controller,
              keyboardType: widget.keyboardType,
              validator: widget.validator,
              autofillHints: widget.autoFillHints,
              onChanged: widget.onChanged,
              onEditingComplete: widget.onEditingComplete,
              obscureText: (widget.isPassword ?? false) &&
                  hidePassword,
              scrollPadding: EdgeInsets.zero,
              cursorColor: kPrimaryThemeColor4,
              showCursor: true,
              cursorHeight: 20,
              style: const TextStyle(fontSize: 16, color: kPrimaryThemeColor4),
              toolbarOptions: const ToolbarOptions(
                  cut: true, copy: true, paste: true, selectAll: true),
              decoration: InputDecoration(
                labelText: widget.hintText,
                errorMaxLines: 2,
                filled: true,
                hintText: widget.hintText,
                fillColor: kSecondaryThemeColor4,
                errorStyle: const TextStyle(),
                border: OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.zero,
                  borderSide: BorderSide(
                    style:
                    (widget.color != null) ? BorderStyle.solid : BorderStyle
                        .none,
                    width: (widget.color != null) ? 1 : 0,
                    color: widget.color ?? Colors.black,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: widget.borderRadius ?? BorderRadius.zero,
                  borderSide: BorderSide(
                    style:
                    (widget.color != null) ? BorderStyle.solid : BorderStyle
                        .none,
                    width: (widget.color != null) ? 1 : 0,
                    color: widget.color ?? Colors.black,
                  ),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.all(8),
              ),
            ),
          ),
          if (widget.isPassword ?? false)
            GestureDetector(
              onTap: () {
                setState(() => hidePassword = !hidePassword);
              },
              child: Image.asset(
                'images/${!hidePassword?'not_':''}seen.png',
                height: 22,
              ),
            ),
        ],
      ),
    );
  }
}
