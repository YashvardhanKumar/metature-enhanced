import 'package:flutter/material.dart';

import '../../../change notifiers/edit_text_post_notifier.dart';
import '../../../constants.dart';
import '../custom_icon_button.dart';

class TextEditingOptions extends StatelessWidget {
  const TextEditingOptions({
    Key? key,
    required this.textPost,
  }) : super(key: key);
  final EditTextPostNotifier textPost;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 500),
      curve: Curves.easeOutCubic,
      height: textPost.textBoxTapped ? 50 : 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          CustomIconButton(
            selected: textPost.textColorPaletteEnabled,
            onPressed: textPost.onTextColorPaletteEnabled,
            icon: Icon(
              Icons.format_color_text_rounded,
              color: kPrimaryThemeColor4,
            ),
          ),
          CustomIconButton(
            selected: textPost.colorPaletteEnabled,
            onPressed: textPost.onBGColorPaletteEnabled,
            icon: Icon(
              Icons.format_color_fill_rounded,
              color: kPrimaryThemeColor4,
            ),
          ),
          CustomIconButton(
            selected: textPost.isEditText,
            onPressed: textPost.onFontStyleMenuEnabled,
            icon: Icon(
              Icons.font_download_rounded,
              color: kPrimaryThemeColor4,
            ),
          ),
          CustomIconButton(
            onPressed: textPost.onTextAlignmentChange,
            icon: Icon(
              (textPost.alignOption == TextAlign.left)
                  ? Icons.format_align_left_rounded
                  : (textPost.alignOption == TextAlign.center)
                      ? Icons.format_align_center_rounded
                      : Icons.format_align_right_rounded,
              color: kPrimaryThemeColor4,
            ),
          ),
        ],
      ),
    );
  }
}

