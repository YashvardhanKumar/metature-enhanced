import 'package:flutter/material.dart';

import '../../../change notifiers/edit_text_post_notifier.dart';
import 'color_picker_button.dart';

class ColorPicker extends StatelessWidget {
  const ColorPicker({Key? key, required this.onClick, required this.onDismiss})
      : super(key: key);
  final ValueChanged<Color> onClick;
  final VoidCallback onDismiss;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              onTap: onDismiss,
              child: const Icon(
                Icons.close_rounded,
                size: 25,
              ),
            ),
            ColorPickerButton(
              color: Colors.black,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.blueGrey,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.grey,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.white,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.red,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.deepOrange,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.orange,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.amber,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.yellow,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.lime,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.lightGreen,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.green,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.teal,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.cyan,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.lightBlue,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.blue,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.indigo,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.deepPurple,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.purple,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.pink,
              onClick: onClick,
            ),
            ColorPickerButton(
              color: Colors.brown,
              onClick: onClick,
            ),
          ],
        ),
      ),
    );
  }
}

class ColorPickerTextPost extends StatelessWidget {
  const ColorPickerTextPost({
    Key? key,
    required this.textPost,
  }) : super(key: key);
  final EditTextPostNotifier textPost;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      curve: Curves.easeInOutCubicEmphasized,
      duration: Duration(milliseconds: 400),
      
      height: textPost.textBoxTapped &&
              (textPost.colorPaletteEnabled || textPost.textColorPaletteEnabled)
          ? 30
          : 0,
      child: ColorPicker(
        onClick: textPost.onColorPickerClick,
        onDismiss: textPost.onColorPickerDismiss,
      ),
    );
  }
}