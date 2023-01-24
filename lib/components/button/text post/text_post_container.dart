import 'dart:math';

import 'package:flutter/material.dart';
import 'package:metature2/constants.dart';

import '../../../change notifiers/edit_text_post_notifier.dart';

class TextPostContainer extends StatefulWidget {
  const TextPostContainer({
    Key? key,
    required this.textPost,
    required this.width,
  }) : super(key: key);
  final EditTextPostNotifier textPost;
  final double width;

  @override
  State<TextPostContainer> createState() => _TextPostContainerState();
}

class _TextPostContainerState extends State<TextPostContainer> {
  late double _top = 0;
  late double _left = 0;
  GlobalKey _key = GlobalKey();
  double scaleUpdateDetails = 1;
  double baseScaleUpdateDetails = 1;
  Offset textOffset = Offset.zero;
  Offset baseTextOffset = Offset.zero;
  bool isPanning = false;
  late TransformationController transformationController;
  late TextEditingController textEditingController;
  late String text;

  @override
  void initState() {
    transformationController = TransformationController();
    textEditingController = TextEditingController();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle =
        widget.textPost.googleFonts[widget.textPost.fontFamily]!(
      color: widget.textPost.textColor,
      decoration:
          (widget.textPost.isUnderline) ? TextDecoration.underline : null,
      fontSize: widget.textPost.fontSize,
      fontStyle: (widget.textPost.isItalic) ? FontStyle.italic : null,
      fontWeight: (widget.textPost.isBold) ? FontWeight.w700 : null,
    );
    return GestureDetector(
      onScaleStart: (details) {
        baseTextOffset = textOffset;
        baseScaleUpdateDetails = scaleUpdateDetails;
        setState(() {});
      },
      onScaleUpdate: (scaleDetails) {
        // RenderBox box =
        // _key.currentContext?.findRenderObject() as RenderBox;
        // Offset position = box.localToGlobal(Offset.zero);
        _top = max(0, min(_top + scaleDetails.focalPointDelta.dy, 600));
        _left = max(0, _left + min(scaleDetails.focalPointDelta.dx, widget.width));
        textOffset = Offset(_left, _top);
        setState(() {});
        // widget.textPost.onFontSizeChanged(widget.textPost.fontSize * scaleDetails.scale);
        scaleUpdateDetails =
            baseScaleUpdateDetails * scaleDetails.scale;
        setState(() {});
      },
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Dialog(
            insetPadding: EdgeInsets.zero,
            backgroundColor: Colors.transparent,
            // height: 600,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.all(20),
                  padding: EdgeInsets.all(20),
                  // height: 600,
                  // width: widget.width,
                  child: TextField(
                    maxLines: null,
                    minLines: 1,
                    autofocus: true,
                    decoration: InputDecoration.collapsed(
                      hintText: 'Enter Text',
                      hintStyle: TextStyle(
                        color: kSecondaryThemeColor4.withAlpha(100),
                      ),
                    ),
                    controller: textEditingController,
                    textAlign: widget.textPost.alignOption,
                    // cursorColor: kSecondaryThemeColor1,
                    style: textStyle,
                    onChanged: (value) => widget.textPost.onChangeText(value),
                  ),
                ),
              ],
            ),
          ),
        );
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOutCubicEmphasized,
        color: widget.textPost.bgColor,
        // alignment: Alignment.center,
        width: widget.width,
        constraints: BoxConstraints(
            minHeight: widget.textPost.textBoxTapped ? 100 : 0,
            maxHeight: widget.textPost.textBoxTapped ? 600 : 0),
        child: Builder(builder: (context) {
          if (widget.textPost.textBoxTapped) {
            return Stack(
              // alignment: Alignment.center,
              children: [
                Positioned(
                  top: _top,
                  left: _left,
                  height: scaleUpdateDetails,
                  width: widget.width,
                  child: GestureDetector(
                    key: _key,
                    // onPanUpdate: (details) {
                    //
                    // },
                    onScaleStart: (details) {
                      baseScaleUpdateDetails = scaleUpdateDetails;
                      setState(() {});
                    },
                    onDoubleTap: () {
                      scaleUpdateDetails = baseScaleUpdateDetails = 1;
                      setState(() {});
                    },
                    onTapDown: (_) {
                      isPanning = true;
                      setState(() {});
                    },
                    onTapUp: (_) {
                      isPanning = false;
                      setState(() {});
                    },
                    onTapCancel: () {
                      // isPanning = false;
                      setState(() {});
                    },
                    onScaleUpdate: (scaleDetails) {
                      // RenderBox box =
                      // _key.currentContext?.findRenderObject() as RenderBox;
                      // Offset position = box.localToGlobal(Offset.zero);
                      _top = max(0, _top + scaleDetails.focalPointDelta.dy);
                      _left = max(0, _left + scaleDetails.focalPointDelta.dx);
                      setState(() {});
                      // widget.textPost.onFontSizeChanged(widget.textPost.fontSize * scaleDetails.scale);
                      scaleUpdateDetails =
                          baseScaleUpdateDetails * scaleDetails.scale;
                      setState(() {});
                    },
                    child: Container(
                      // duration: Duration(milliseconds: 500),
                      // curve: (scaleUpdateDetails < 1)
                      //     ? Curves.easeOut
                      //     : Curves.easeIn,
                      // height: 50 * scaleUpdateDetails,
                      // width: 80 * scaleUpdateDetails,
                      // width: widget.width,
                      color: kPrimaryThemeColor1,
                      // margin: EdgeInsets.all(30),
                      // padding: const EdgeInsets.all(30),
                      child: Column(
                        children: [
                          SizedBox(height: 15,),
                          Row(
                            children: [
                              SizedBox(width: 15,),
                              Text(
                                widget.textPost.postText == ''
                                    ? 'Enter text'
                                    : widget.textPost.postText,
                                // controller: textEditingController,
                                textAlign: widget.textPost.alignOption,
                                textScaleFactor: scaleUpdateDetails,
                                style: textStyle,
                                // focusNode: FocusNode(),
                                // cursorColor: kSecondaryThemeColor1,
                                // backgroundCursorColor: kSecondaryThemeColor1,
                              ),
                              SizedBox(width: 15,),
                            ],
                          ),
                          SizedBox(height: 15,),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// import '../../../change notifiers/edit_text_post_notifier.dart';

// class TextPostContainer extends StatelessWidget {
//   const TextPostContainer({
//     Key? key,
//     required this.textPost,
//     required this.width,
//   }) : super(key: key);
//   final EditTextPostNotifier textPost;
//   final double width;
//   @override
//   Widget build(BuildContext context) {
//     return AnimatedContainer(
//       duration: Duration(milliseconds: 200),
//       curve: Curves.easeInOutCubic,
//       color: textPost.bgColor,
//       // alignment: Alignment.center,
//       constraints: BoxConstraints(
//           minHeight: textPost.textBoxTapped ? 100 : 0,
//           maxHeight: textPost.textBoxTapped ? 600 : 0),
//       child: Builder(builder: (context) {
//         if (textPost.textBoxTapped) {
//           return Container(
//             width: width,
//             padding: const EdgeInsets.all(15),
//             child: Text(
//               textPost.postText == '' ? 'Enter text' : textPost.postText,
//               textAlign: textPost.alignOption,
//               style: textPost.googleFonts[textPost.fontFamily]!(
//                 color: textPost.textColor,
//                 decoration:
//                     (textPost.isUnderline) ? TextDecoration.underline : null,
//                 fontSize: textPost.fontSize,
//                 fontStyle: (textPost.isItalic) ? FontStyle.italic : null,
//                 fontWeight: (textPost.isBold) ? FontWeight.w700 : null,
//               ),
//             ),
//           );
//         }
//         return Container();
//       }),
//     );
//   }
// }
