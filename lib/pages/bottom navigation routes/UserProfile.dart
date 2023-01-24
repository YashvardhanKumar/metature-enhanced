import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metature2/change%20notifiers/google_sign_in.dart';
import 'package:metature2/components/button/Custombutton.dart';
import 'package:metature2/components/colored_text.dart';
import 'package:metature2/constants.dart';
import 'package:metature2/models/profile_model.dart';
import 'package:metature2/pages/edit_profile.dart';
import 'package:provider/provider.dart';

import '../../components/custom_page_route.dart';
import '../../components/grids/profile_post_grid.dart';
import '../../components/profile_pic_background.dart';
import '../../components/sticky_sliver.dart';
import '../home_page.dart';

CollectionReference _user = FirebaseFirestore.instance.collection('user');
FirebaseAuth _auth = FirebaseAuth.instance;

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  int _currentMax = 12;

  getMoreData() {
    _currentMax += 12;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  int? idx;

  @override
  Widget build(BuildContext context) {
    Size displaySize = MediaQuery.of(context).size;
    return StreamBuilder<DocumentSnapshot<UserModel>>(
        stream: _user
            .doc(_auth.currentUser!.uid)
            .withConverter<UserModel>(
              fromFirestore: (snapshots, _) =>
                  UserModel.fromJson(snapshots.data()!),
              toFirestore: (user, _) => user.toJson(),
            )
            .snapshots(includeMetadataChanges: true),
        builder: (context, userSnapshots) {
          final userDetails = userSnapshots.data?.data();
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: Colors.white,
              title: NormalText(
                userDetails?.username,
                nullWidth: 150,
                fontSize: 24,
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Provider.of<GoogleSignInProvider>(context, listen: false)
                          .logout();
                      FirebaseAuth.instance.signOut().then(
                            (value) => Navigator.pushReplacement(
                              context,
                              CustomPageRoute(
                                child: const HomePage(),
                              ),
                            ),
                          );
                    },
                    icon: const Icon(Icons.logout))
              ],
            ),
            body: Container(
              color: kPrimaryThemeColor1,
              child: NestedScrollView(
                headerSliverBuilder: (context, _) => [
                  SliverPersistentHeader(
                    delegate:
                        CustomSliverAppBarDelegate(userDetails?.photo_url),
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
                                userDetails?.name,
                                nullWidth: 100,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              NormalText(
                                userDetails != null
                                    ? userDetails.bio ?? ''
                                    : null,
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
                        CustomButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              CustomPageRoute(
                                child: const EditProfile(),
                              ),
                            );
                          },
                          width: double.maxFinite,
                          height: 35,
                          child: const NormalText(
                            'Edit Profile',
                            color: kPrimaryThemeColor1,
                          ),
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
        });
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