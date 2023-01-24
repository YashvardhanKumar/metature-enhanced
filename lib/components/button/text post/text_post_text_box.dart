import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metature2/components/colored_text.dart';
import 'package:provider/provider.dart';

import '../../../change notifiers/edit_text_post_notifier.dart';
import '../../../constants.dart';
import '../post_options/add_post_button.dart';

class TextPostTextBox extends StatefulWidget {
  const TextPostTextBox({
    Key? key,
    required FocusNode focusNode,
  })  : _focusNode = focusNode,
        super(key: key);

  final FocusNode _focusNode;

  @override
  State<TextPostTextBox> createState() => _TextPostTextBoxState();
}

class _TextPostTextBoxState extends State<TextPostTextBox> {
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Consumer<EditTextPostNotifier>(builder: (context, textPost, child) {
      return AnimatedContainer(
        duration: Duration(milliseconds: 400),
        height: textPost.textBoxTapped ? 0 : 52,
        curve: Curves.easeInOutCubicEmphasized,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: kPrimaryThemeColor1,
        ),
        clipBehavior: Clip.hardEdge,
        // padding: const EdgeInsets.all(14.0),
        margin: textPost.textBoxTapped ? EdgeInsets.zero : EdgeInsets.all(4),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: textPost.onTextBoxTapped,
                child: Container(
                  // alignment: Alignment.center,
                  padding: const EdgeInsets.all(14.0),
                  child: NormalText(
                    'Type a post',
                    fontSize: 15,
                  ),
                ),
              ),
            ),
            // if (!textPost.textBoxTapped)
            AnimatedContainer(
              height: textPost.textBoxTapped ? 0 : 44,
              margin: EdgeInsets.all(textPost.textBoxTapped ? 0 : 4),
              // padding: const EdgeInsets.all(5),
              // curve: Curves.easeOut,
              curve: Curves.easeInOutCubicEmphasized,

              duration: Duration(milliseconds: 300),
              child: (!textPost.textBoxTapped) ? AddPostButton() : null,
            ),
          ],
        ),
      );
    });
  }
}

// Form(
//                   key: _formKey,
//                   child: TextFormField(
//                     controller: textPost.textController,
//                     focusNode: widget._focusNode,
//                     validator: (value) {
//                       if (value != null && value.length > 600) {
//                         return 'Cannot exceed the limit';
//                       }
//                     },
//                     maxLines: textPost.textBoxTapped ? 8 : 1,
//                     minLines: textPost.textBoxTapped ? 3 : 1,
//                     maxLength: textPost.textBoxTapped ? 600 : null,
//                     onTap: textPost.onTextBoxTapped,
//                     onChanged: (value) {
//                       _formKey.currentState!.validate();
//                       textPost.onChangeText(value.trim());
//                     },
//                     decoration: InputDecoration(
//                       isCollapsed: true,
//                       hintText: 'Type a post ...',
//                       hintStyle: GoogleFonts.poppins(
//                         color: kSecondaryThemeColor2,
//                       ),
//                       border: InputBorder.none,
//                     ),
//                   ),
//                 ),