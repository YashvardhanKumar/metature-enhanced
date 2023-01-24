import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:metature2/change%20notifiers/edit_text_post_notifier.dart';
import 'package:metature2/change%20notifiers/post_crud_notifier.dart';
import 'package:metature2/components/button/Custombutton.dart';
import 'package:metature2/components/button/text%20post/color_picker.dart';
import 'package:metature2/components/colored_text.dart';
import 'package:metature2/pages/main_page.dart';
import 'package:provider/provider.dart';
import '../../constants.dart';
import '../button/custom_icon_button.dart';
import '../button/post_options/add_post_button.dart';
import '../button/post_options/add_status_button.dart';
import '../button/post_options/add_feed_post_button.dart';
import '../button/text post/font_style_changer_menu.dart';
import '../button/text post/text_editing_options.dart';
import '../button/text post/text_post_container.dart';
import '../button/text post/text_post_post_button.dart';
import '../button/text post/text_post_text_box.dart';
import 'story_circle_card.dart';

class StoryPostLaneCard extends StatefulWidget {
  const StoryPostLaneCard({
    Key? key,
  }) : super(key: key);

  @override
  State<StoryPostLaneCard> createState() => _StoryPostLaneCardState();
}

class _StoryPostLaneCardState extends State<StoryPostLaneCard> {
  double storyBoxHeight = 0;
  GlobalKey storyBoxKey = GlobalKey();
  FocusNode focusNode = FocusNode();
  double searchFieldSize = 100;
  bool showStoryLane = true;
  @override
  void initState() {
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        searchFieldSize = 500;

        setState(() {});
      }
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<EditTextPostNotifier, PostCRUD>(
        builder: (context, textPost, postCRUD, child) {
      Widget ssChild = TextPostContainer(
        textPost: textPost,
        width: MediaQuery.of(context).size.width,
      );
      return WillPopScope(
        onWillPop: () async {
          if (textPost.textBoxTapped) {
            textPost.textBoxTapped = false;
            textPost.onWillPop();
            setState(() {});
            return false;
          }
          return true;
        },
        child: LayoutBuilder(builder: (context, constraint) {
          return Container(
            // curve: Curves.bounceOut,
            // height: textPost.textBoxTapped
            //     ? MediaQuery.of(context).size.height
            //     : 170,

            clipBehavior: Clip.hardEdge,
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height - 75,
            ),
            decoration: BoxDecoration(
              borderRadius: textPost.textBoxTapped
                  ? BorderRadius.zero
                  : BorderRadius.circular(12),
              color: kSecondaryThemeColor4,
            ),
            margin: textPost.textBoxTapped
                ? EdgeInsets.zero
                : const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize:
                  textPost.textBoxTapped ? MainAxisSize.max : MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Stack(
                  children: [
                    ssChild,
                    Column(
                      children: [
                        ColorPickerTextPost(textPost: textPost),
                        Padding(
                          padding: EdgeInsets.only(
                              top: textPost.textBoxTapped ? 8.0 : 0),
                          child: TextEditingOptions(textPost: textPost),
                        ),
                        FontStyleBox(textPost: textPost),
                        // const Flexible(child: SizedBox()),
                      ],
                    ),
                    // TextPostPostButton(
                    //   ssChild: ssChild,
                    //   textPost: textPost,
                    //   postCRUD: postCRUD,
                    // ),
                  ],
                ),
                // const SizedBox(height: 4),
                // ColorPickerTextPost(textPost: textPost),
                // TextEditingOptions(textPost: textPost),
                // FontStyleBox(textPost: textPost),
                if (!textPost.textBoxTapped) const SizedBox(height: 4),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const SizedBox(width: 5),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeInOut,
                      height: textPost.textBoxTapped ? 0 : 34,
                      width: textPost.textBoxTapped ? 0 : 34,
                      child: GestureDetector(
                        onTap: () => Provider.of<CurIndex>(context).changeTo(3),
                        child: CircleAvatar(
                          radius: 17,
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.white,
                          child: Image.asset(
                            'images/User.png',
                          ),
                        ),
                      ),
                    ),
                    if (!textPost.textBoxTapped) const SizedBox(width: 5),
                    Expanded(
                      child: AnimatedContainer(
                        duration: Duration(milliseconds: 400),
                        curve: Curves.easeInOutCubicEmphasized,
                        child: TextPostTextBox(focusNode: focusNode),
                      ),
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                  ],
                ),
                // if (!textPost.textBoxTapped)
                TextPostPostButton(
                  ssChild: ssChild,
                  textPost: textPost,
                  postCRUD: postCRUD,
                ),

                AnimatedContainer(
                  duration: Duration(milliseconds: 400),
                  curve: Curves.easeInOutCubicEmphasized,
                  margin: textPost.textBoxTapped
                      ? EdgeInsets.zero
                      : EdgeInsets.only(top: 15, bottom: 4),
                  child: !textPost.textBoxTapped ? const StoryLane() : null,
                ),
              ],
            ),
          );
        }),
      );
    });
  }
}

class StoryLane extends StatelessWidget {
  const StoryLane({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          const StoryCircleCard(),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 3),
            height: 70,
            width: 0.5,
            color: kSecondaryThemeColor1,
          ),
          const StoryCircleCard(),
          const StoryCircleCard(),
          const StoryCircleCard(),
          const StoryCircleCard(),
          const StoryCircleCard(),
          const StoryCircleCard(),
          const StoryCircleCard(),
        ],
      ),
    );
  }
}
