import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metature2/change%20notifiers/google_sign_in.dart';
import 'package:metature2/components/button/Custombutton.dart';
import 'package:metature2/components/colored_text.dart';
import 'package:metature2/components/progress_circle.dart';
import 'package:metature2/constants.dart';
import 'package:metature2/models/friend_model.dart';
import 'package:metature2/models/profile_model.dart';
import 'package:metature2/pages/chat%20page/chat_screen.dart';
import 'package:metature2/pages/edit_profile.dart';
import 'package:metature2/stream%20builder/friend_status.dart';
import 'package:provider/provider.dart';

import '../../components/cards/post_grid.dart';
import '../../components/custom_page_route.dart';
import '../../components/profile_pic_background.dart';
import '../../components/sticky_sliver.dart';
import '../components/grids/profile_post_grid.dart';
import 'bottom navigation routes/UserProfile.dart';
import 'home_page.dart';

CollectionReference _user = FirebaseFirestore.instance.collection('user');
FirebaseAuth _auth = FirebaseAuth.instance;

class ExternalProfilePage extends StatefulWidget {
  const ExternalProfilePage({Key? key, required this.userModel})
      : super(key: key);
  final UserModel userModel;
  @override
  State<ExternalProfilePage> createState() => _ExternalProfilePageState();
}

class _ExternalProfilePageState extends State<ExternalProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final scrollController = ScrollController();
  int _currentMax = 12;
  FriendStatus? friendStatus;
  FriendStatusChecker status = FriendStatusChecker();
  bool friendButtonPressed = false;
  getMoreData() {
    _currentMax += 12;
    setState(() {});
  }

  @override
  void initState() {
    status.checkFriendStatus(widget.userModel.uid).then(
          (value) => setState(() => friendStatus = value),
        );
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

    scrollController.addListener(() {
      print(scrollController.position.pixels);
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        getMoreData();
      }
    });
  }

  @override
  void dispose() {
    _tabController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  int? idx;

  @override
  Widget build(BuildContext context) {
    final userDetails = widget.userModel;
    Size displaySize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: NormalText(
          widget.userModel.username,
          nullWidth: 150,
          fontSize: 24,
        ),
      ),
      body: Container(
        color: kPrimaryThemeColor1,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) => [
            SliverPersistentHeader(
              delegate: CustomSliverAppBarDelegate(userDetails.photo_url),
            ),
            const SliverToBoxAdapter(
              child: Divider(
                color: kSecondaryThemeColor2,
                indent: 140,
                endIndent: 10,
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NormalText(
                          userDetails.name,
                          nullWidth: 100,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        NormalText(
                          userDetails.bio ?? '',
                          nullWidth: 200,
                          fontSize: 12,
                          color: kSecondaryThemeColor2,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  if (friendStatus != null)
                    ExternalProfileFriendButton(
                      userModel: widget.userModel,
                      friendStatus: friendStatus,
                      onPressedLeftButton: () async {
                        friendButtonPressed = true;
                        setState(() {});
                        FriendRequestModel request = FriendRequestModel(
                          requestSentToUid: widget.userModel.uid,
                          sentAt: Timestamp.now().toDate(),
                        );
                        if (friendStatus == FriendStatus.none) {
                          status.sendFriendRequest(request);
                        } else if (friendStatus == FriendStatus.requestSent) {
                          status.deleteFriendRequest(request.requestSentToUid);
                        } else if (friendStatus ==
                            FriendStatus.requestReceived) {
                          status.acceptFriendRequest(request);
                        } else if (friendStatus == FriendStatus.friends) {
                          status.removeFriend(request.requestSentToUid);
                        }
                        friendStatus = await status
                            .checkFriendStatus(widget.userModel.uid);
                        friendButtonPressed = false;
                        setState(() {});
                      },
                      onPressedRightButton: () {
                        Navigator.push(
                            context, CustomPageRoute(child: ChatScreen()));
                      },
                    ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
            StickySliver(
              child: Container(
                height: 50,
                alignment: Alignment.centerLeft,
                child: TabBar(
                  indicatorColor: kPrimaryThemeColor4,
                  labelColor: kPrimaryThemeColor4,
                  labelPadding: const EdgeInsets.only(left: 0),
                  unselectedLabelColor: kSecondaryThemeColor2,
                  controller: _tabController,
                  tabs: const [
                    Tab(
                      text: 'All posts',
                    ),
                    Tab(
                      text: 'Photos',
                    ),
                    Tab(
                      text: 'Videos',
                    ),
                  ],
                ),
              ),
            ),
          ],
          body: SizedBox(
            width: double.maxFinite,
            height: displaySize.height - kToolbarHeight - 74,
            child: TabBarView(
              controller: _tabController,
              children: [
                const ProfilePostGrid(),
                const ProfilePostGrid(),
                const ProfilePostGrid(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CustomSliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  String? url;

  CustomSliverAppBarDelegate(this.url);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return ProfilePicBackground(url: url);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => 260;

  @override
  // TODO: implement minExtent
  double get minExtent => 260;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
    return true;
  }
}

class ExternalProfileFriendButton extends StatelessWidget {
  const ExternalProfileFriendButton({
    super.key,
    required this.userModel,
    required this.friendStatus,
    required this.onPressedLeftButton,
    required this.onPressedRightButton,
  });

  final UserModel userModel;
  final FriendStatus? friendStatus;
  final VoidCallback? onPressedLeftButton, onPressedRightButton;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 4,
          child: Builder(builder: (context) {
            return CustomButton(
              onPressed: onPressedLeftButton,
              height: 35,
              colorString: ((friendStatus == FriendStatus.requestSent ||
                          friendStatus == FriendStatus.friends)
                      ? kSecondaryThemeColor2
                      : kPrimaryThemeColor4)
                  .value,
              child: Builder(builder: (context) {
                if (friendStatus == FriendStatus.none) {
                  return const NormalText(
                    'Send Request',
                    color: kPrimaryThemeColor1,
                  );
                } else if (friendStatus == FriendStatus.requestSent) {
                  return const NormalText(
                    'Cancel Request',
                    color: kPrimaryThemeColor2,
                  );
                } else if (friendStatus == FriendStatus.requestReceived) {
                  return const NormalText(
                    'Accept Request',
                    color: kPrimaryThemeColor1,
                  );
                }
                return const NormalText(
                  'Remove Friend',
                  color: kPrimaryThemeColor1,
                );
              }),
            );
          }),
        ),
        Expanded(
          flex: 5,
          child: CustomButton(
            onPressed: onPressedRightButton,
            colorString: kSecondaryThemeColor1.value,
            height: 35,
            child: const NormalText(
              'Message as stranger',
              color: kPrimaryThemeColor1,
            ),
          ),
        ),
      ],
    );
  }
}
