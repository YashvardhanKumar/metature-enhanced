import 'dart:ui';

import 'package:flutter/material.dart';

import '../button/like_comment_numbers.dart';
import '../button/like_comment_share_buttons.dart';
import '../button/post_setting_button.dart';
import '../button/poster_info.dart';
import '../colored_text.dart';

class PostCard extends StatefulWidget {
  const PostCard({
    Key? key,
  }) : super(key: key);

  @override
  State<PostCard> createState() => _PostCardState();
}

class _PostCardState extends State<PostCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation _animation;
  AnimationStatus _animationStatus = AnimationStatus.forward;
  bool isLiked = false;
  @override
  void initState() {
    _controller = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1000));
    _animation = CurvedAnimation(parent: _controller, curve: Curves.elasticOut);
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            Container(
              constraints: const BoxConstraints(maxHeight: 550, minHeight: 250),
              child: Image.asset(
                'images/girl_sample_post.png',
                fit: BoxFit.fill,
              ),
            ),
          ],
        ),
        ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
            child: Card(
              elevation: 0,
              color: Colors.transparent,
              margin: const EdgeInsets.all(10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              // color: kBlueThemeColor4,
              child: Container(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          children: [
                            GestureDetector(
                              onDoubleTap: () {
                                isLiked = true;
                                _controller.forward();
                                _animation.addStatusListener((status) {
                                  setState(() {
                                    _animationStatus = status;
                                    print(_animationStatus);
                                  });
                                  if (status == AnimationStatus.completed) {
                                    _controller.reverse();
                                  }
                                });
                                _controller.addListener(() {
                                  // print(_animation.value);
                                  setState(() {});
                                });
                              },
                              child: Container(
                                constraints: const BoxConstraints(
                                    maxHeight: 500, minHeight: 200),
                                // height: 400,
                                margin: const EdgeInsets.only(bottom: 8),
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Image.asset(
                                    'images/girl_sample_post.png',
                                    fit: BoxFit.fitWidth,
                                  ),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white54,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  LikeCommentShareOptions(liked: isLiked),
                                  const LikeCommentStats(),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Center(
                          child: SizedBox(
                            height: (_animation.value) < 0
                                ? 25
                                : _animation.value * 150,
                            width: (_animation.value) < 0
                                ? 25
                                : _animation.value * 150,
                            child: Image.asset(
                              'images/heart_red.png',
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(12),
                              topLeft: Radius.circular(12))),
                      // margin: const EdgeInsets.all(8.0),
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          PostUserDetail(),
                          PostSettingsButton(),
                        ],
                      ),
                    ),
                    const Divider(
                      height: 0,
                      endIndent: 10,
                      indent: 10,
                      color: Colors.black45,
                    ),
                    // SizedBox(height: 8,),
                    Container(
                      decoration: const BoxDecoration(
                          color: Colors.white54,
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(12),
                              bottomRight: Radius.circular(12))),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8.0, vertical: 4),
                      child: Row(
                        children: const [
                          NormalText('Just A Passing Cloud..'),
                          NormalText(
                            ' ..Expand',
                            fontWeight: FontWeight.w500,
                          )
                        ],
                      ),
                    ),
                    // Divider()
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
