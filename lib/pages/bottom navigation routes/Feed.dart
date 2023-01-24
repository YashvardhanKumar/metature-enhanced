import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:metature2/change%20notifiers/edit_text_post_notifier.dart';
import 'package:metature2/change%20notifiers/post_crud_notifier.dart';
import 'package:provider/provider.dart';

import '../../components/button/search and dm button/app_bar_options_search_dms_card.dart';
import '../../components/cards/post_card.dart';
import '../../components/cards/story_posts_lane_card.dart';
import '../../components/progress_circle.dart';
import '../../models/post_model.dart';

class FeedPage extends StatefulWidget {
  const FeedPage({
    Key? key,
  }) : super(key: key);

  @override
  State<FeedPage> createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage> {
  final controller = PageController(initialPage: 0);
  final scrollController = ScrollController();
  int _currentMax = 2;

  getMoreData() {
    _currentMax += 3;
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer2<PostCRUD, EditTextPostNotifier>(
          builder: (context, postCRUD, textPost, child) {
        return Scaffold(
          appBar: FeedAppBar(isTextBoxTapped: textPost.textBoxTapped),
          body: Container(
            color: Colors.white,
            height: MediaQuery.of(context).size.height,
            child: StreamBuilder<QuerySnapshot<Post>>(
                stream: FirebaseFirestore.instance
                    .collection('post')
                    .withConverter(
                      fromFirestore: (snapshot, options) =>
                          Post.fromJson(snapshot.data()!),
                      toFirestore: (value, options) => value.toJson(),
                    )
                    .snapshots(),
                builder: (context, snapshot) {
                  return ListView.builder(
                    controller: scrollController,
                    physics: textPost.textBoxTapped
                        ? BouncingScrollPhysics()
                        : BouncingScrollPhysics(),
                    itemCount: _currentMax + 2,
                    itemBuilder: (BuildContext context, int index) {
                      if (index == 0) {
                        return StoryPostLaneCard();
                      } else if (index == _currentMax + 1) {
                        return textPost.textBoxTapped
                            ? Container()
                            : ProgressCircle();
                      } else {
                        return textPost.textBoxTapped
                            ? Container()
                            : PostCard();
                      }
                    },
                  );
                }),
          ),
        );
      }),
    );
  }
}

class FeedAppBar extends StatefulWidget implements PreferredSizeWidget {
  double height = 56.0;

  FeedAppBar({
    super.key,
    required this.isTextBoxTapped,
  });
  final bool isTextBoxTapped;
  @override
  State<FeedAppBar> createState() => _FeedAppBarState();

  @override
  Size get preferredSize => Size.fromHeight(height);
}

class _FeedAppBarState extends State<FeedAppBar> {
  late double height;
  @override
  void initState() {
    height = widget.preferredSize.height;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: widget.isTextBoxTapped ? 0 : height,
      duration: Duration(milliseconds: 400),
      curve: Curves.easeInOutCubicEmphasized,
      child: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset(
              'images/logo_appbar.png',
              height: 20,
            ),
            AppBarOptionSearchDms(),
          ],
        ),
      ),
    );
  }
}
