import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:metature2/change%20notifiers/post_crud_notifier.dart';
import 'package:metature2/components/progress_circle.dart';

import '../../../change notifiers/edit_text_post_notifier.dart';
import '../../../constants.dart';
import '../../colored_text.dart';
import '../Custombutton.dart';

class TextPostPostButton extends StatelessWidget {
  const TextPostPostButton({
    Key? key,
    required this.textPost,
    required this.ssChild,
    required this.postCRUD,
  }) : super(key: key);
  final Widget ssChild;
  final EditTextPostNotifier textPost;
  final PostCRUD postCRUD;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: !textPost.textBoxTapped ? 0 : 59,
      // margin: EdgeInsets.only(top: !textPost.textBoxTapped ? 0 : 15),
      curve: Curves.easeOut,
      duration: const Duration(milliseconds: 300),
      child: (textPost.textBoxTapped)
          ? CustomButton(
              height: !textPost.textBoxTapped ? 0 : 45,
              onPressed: !textPost.textBoxTapped || textPost.postText == ''
                  ? null
                  : () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        isScrollControlled: true,
                        context: context,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30),
                          ),
                        ),
                        builder: (context) => TextPostBottomSheet(
                          textPost: textPost,
                          ssChild: ssChild,
                          postCRUD: postCRUD,
                        ),
                      );
                    },
              child: !textPost.textBoxTapped
                  ? null
                  : const NormalText(
                      'Post',
                      color: kPrimaryThemeColor1,
                    ),
            )
          : null,
    );
  }
}

class TextPostBottomSheet extends StatefulWidget {
  const TextPostBottomSheet({
    Key? key,
    required this.textPost,
    required this.ssChild,
    required this.postCRUD,
  }) : super(key: key);

  final EditTextPostNotifier textPost;
  final Widget ssChild;
  final PostCRUD postCRUD;

  @override
  State<TextPostBottomSheet> createState() => _TextPostBottomSheetState();
}

class _TextPostBottomSheetState extends State<TextPostBottomSheet> {
  List<String> visibleTo = [
    "acquaintances",
    "friends",
    "close_friends",
    "best_friends"
  ];

  List<bool> isSelected = [true, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Material(
              color: Colors.grey[400],
              shape: const StadiumBorder(),
              child: const SizedBox(
                height: 3,
                width: 50,
              ),
            ),
          ),
          const NormalText(
            'Share this post to',
            fontSize: 25,
          ),
          const Divider(
            // height: 2,
            indent: 20,
            endIndent: 20,
          ),
          SizedBox(
            height: 300,
            child: Material(
              color: Colors.transparent,
              child: Column(
                children: [
                  ListTile(
                    trailing: isSelected[0]
                        ? const CircleAvatar(
                            radius: 10,
                            backgroundImage: AssetImage('images/check.png'),
                          )
                        : null,
                    selected: isSelected[0],
                    title: const NormalText('Everyone'),
                    onTap: () {
                      visibleTo = [
                        "acquaintances",
                        "friends",
                        "close_friends",
                        "best_friends"
                      ];
                      isSelected = [true, false, false, false, false];
                      setState(() {});
                    },
                  ),
                  ListTile(
                    trailing: isSelected[1]
                        ? const CircleAvatar(
                            radius: 10,
                            backgroundImage: AssetImage('images/check.png'),
                          )
                        : null,
                    selected: isSelected[1],
                    title: const NormalText('Friends'),
                    subtitle: const Text('This excludes acquaintances'),
                    onTap: () {
                      visibleTo = ["friends", "close_friends", "best_friends"];
                      isSelected = [false, true, false, false, false];
                      setState(() {});
                    },
                  ),
                  ListTile(
                    trailing: isSelected[2]
                        ? const CircleAvatar(
                            radius: 10,
                            backgroundImage: AssetImage('images/check.png'),
                          )
                        : null,
                    selected: isSelected[2],
                    title: const NormalText('Close Friends'),
                    onTap: () {
                      visibleTo = ["close_friends", "best_friends"];
                      isSelected = [false, false, true, false, false];
                      setState(() {});
                    },
                  ),
                  ListTile(
                    trailing: isSelected[3]
                        ? const CircleAvatar(
                            radius: 10,
                            backgroundImage: AssetImage('images/check.png'),
                          )
                        : null,
                    selected: isSelected[3],
                    title: const NormalText('Best Friends'),
                    onTap: () {
                      visibleTo = ["best_friends"];
                      isSelected = [false, false, false, true, false];
                      setState(() {});
                    },
                  ),
                  ListTile(
                    trailing: isSelected[4]
                        ? const CircleAvatar(
                            radius: 10,
                            backgroundImage: AssetImage('images/check.png'),
                          )
                        : null,
                    title: const NormalText('Keep it unlisted'),
                    onTap: () {
                      visibleTo = [];
                      isSelected = [false, false, false, false, true];
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 70,
            color: kSecondaryThemeColor4,
            alignment: Alignment.center,
            child: CustomButton(
              width: double.maxFinite,
              onPressed: widget.textPost.disableButton
                  ? null
                  : () async {
                      widget.textPost.createByteImage(widget.ssChild);
                      await widget.postCRUD.uploadBytes(
                        visibleTo,
                        widget.textPost.bytes,
                        widget.textPost.postText,
                      );
                      widget.textPost.resetTextFormatting();
                      widget.textPost.enableButton();
                    },
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  if (widget.postCRUD.uploadTask != null)
                    StreamBuilder<TaskSnapshot>(
                      stream: widget.postCRUD.uploadTask!.snapshotEvents,
                      builder: (context, snapshot) {
                        final data = snapshot.data;
                        print(data?.bytesTransferred.toDouble());
                        if (snapshot.hasData) {
                          print('object');
                          return ProgressCircle(
                            value: data!.bytesTransferred.toDouble() /
                                data.totalBytes.toDouble(),
                          );
                        }
                        return Container();
                      },
                    ),
                  const Center(
                    child: NormalText(
                      'Post',
                      color: kSecondaryThemeColor4,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
