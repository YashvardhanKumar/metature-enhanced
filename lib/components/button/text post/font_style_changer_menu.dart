import 'package:flutter/material.dart';

import '../../../change notifiers/edit_text_post_notifier.dart';
import '../../../constants.dart';
import '../../colored_text.dart';
import '../custom_icon_button.dart';

class FontStyleBox extends StatelessWidget {
  const FontStyleBox({
    Key? key,
    required this.textPost,
  }) : super(key: key);
  final EditTextPostNotifier textPost;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 300),
      curve: Curves.easeOutCubic,
      color: kPrimaryThemeColor1.withAlpha(100),
      margin: EdgeInsets.only(top: !textPost.isEditText ? 0 : 8),
      padding: EdgeInsets.all(!textPost.isEditText ? 0 : 8),
      height: textPost.isEditText ? 200 : 0,
      // onEnd: () => setState(() => isEditText = false),
      child: Column(
        children: [
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                CustomIconButton(
                  selected: textPost.isBold,
                  onPressed: textPost.onBoldClick,
                  icon: Icon(
                    Icons.format_bold_rounded,
                    color: kSecondaryThemeColor2,
                  ),
                ),
                CustomIconButton(
                  onPressed: textPost.onItalicClick,
                  selected: textPost.isItalic,
                  icon: Icon(
                    Icons.format_italic_rounded,
                    color: kSecondaryThemeColor2,
                  ),
                ),
                CustomIconButton(
                  selected: textPost.isUnderline,
                  onPressed: textPost.onUnderlineClick,
                  icon: Icon(
                    Icons.format_underline_rounded,
                    color: kSecondaryThemeColor2,
                  ),
                ),
              ],
            ),
          ),
          if (textPost.isEditText)
            FontSizeChangerSlider(textPost: textPost),
          Expanded(
            child: FontFamilyChangerDropDown(textPost: textPost),
          ),
        ],
      ),
    );
  }
}

class FontFamilyChangerDropDown extends StatelessWidget {
  const FontFamilyChangerDropDown({
    Key? key,
    required this.textPost,
  }) : super(key: key);

  final EditTextPostNotifier textPost;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          NormalText(
            'Font Style',
          ),
          DropdownButton(
            underline: Container(),
            borderRadius: BorderRadius.circular(10),
            elevation: 30,
            dropdownColor: kPrimaryThemeColor2,
            value: textPost.fontFamily,
            onChanged: textPost.onFontFamilyChanged,
            menuMaxHeight: 200,
            items: [
              'Roboto',
              'Source Sans Pro',
              'Raleway',
              'Teko',
              'Bebas Neue',
              'Lobster',
              'Mali',
              'Special Elite',
              'IBM Plex Mono',
              'Coda',
              'Unica One',
              'Audiowide',
              'Forum'
            ]
                .map(
                  (e) => DropdownMenuItem<String>(
                    value: e,
                    child: Text(
                      e,
                      style: textPost.googleFonts[e](
                        color: kSecondaryThemeColor2,
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}

class FontSizeChangerSlider extends StatelessWidget {
  const FontSizeChangerSlider({
    Key? key,
    required this.textPost,
  }) : super(key: key);

  final EditTextPostNotifier textPost;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          Center(
            child: NormalText(
              'Font Size',
            ),
          ),
          // Expanded(
          //   child: Slider(
          //     max: 50.0,
          //     min: 10.0,
          //     divisions: 50,
          //     value: textPost.fontSize,
          //     label: '${textPost.fontSize.toInt()}',
          //     onChanged: textPost.onFontSizeChanged,
          //     activeColor: kPrimaryThemeColor3,
          //   ),
          // ),
        ],
      ),
    );
  }
}
