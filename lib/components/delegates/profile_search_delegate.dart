import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../SearchAlgo.dart';
import '../../models/profile_model.dart';
import '../../pages/UserProfileOthers.dart';
import '../../pages/bottom navigation routes/Feed.dart';
import '../../stream builder/friend_status.dart';
import '../colored_text.dart';
import '../custom_page_route.dart';
import '../progress_circle.dart';

CollectionReference _user = FirebaseFirestore.instance.collection('user');

class ProfilePageSearchPage extends StatefulWidget {
  const ProfilePageSearchPage({Key? key}) : super(key: key);

  @override
  State<ProfilePageSearchPage> createState() => _ProfilePageSearchPageState();
}

class _ProfilePageSearchPageState extends State<ProfilePageSearchPage> {
  String query = '';

  // Timer? timer;

  TextEditingController queryController = TextEditingController();

  bool showLoading = false;
  bool expand = false;

  List<UserModel> results = [];
  QuerySnapshot<UserModel>? querySnapshot;

  void getSearchData() async {
    querySnapshot = await _user
        .limit(60)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (users, _) => users.toJson(),
        )
        .get();

    SearchAlgorithm searchAlgorithm =
        SearchAlgorithm(querySnapshot!.docs.map((e) => e.data()).toList());
    results = searchAlgorithm.searchResult(query);
    setState(() {});
    print(results[9].uid.toString());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    print('disposed scroll');
    super.dispose();
  }

  List<Widget>? buildActions(BuildContext context) {
    // TODO: implement buildActions
    return [
      GestureDetector(
        onTap: () {
          query = '';
          queryController.clear();
          setState(() {});
        },
        child: const Padding(
          padding: EdgeInsets.all(12.0),
          child: Icon(Icons.clear),
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: buildActions(context),
        title: TextField(
          textInputAction: TextInputAction.search,
          decoration: const InputDecoration(border: InputBorder.none),
          onChanged: (value) {
            setState(() {
              query = value;
              showLoading = true;
              expand = false;
              if (query.isNotEmpty) {
                getSearchData();
              }
              showLoading = false;
            });
          },
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          (querySnapshot == null && query.isNotEmpty)
              ? ProgressCircle()
              : Builder(builder: (context) {
                  if (query.isEmpty) {
                    print(query);
                    return const Center(child: NormalText('Search people'));
                  }
                  if (results.isEmpty && querySnapshot != null) {
                    return const Center(child: NormalText('No results found'));
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount:
                          (expand) ? results.length : min(results.length, 5),
                      itemBuilder: (context, i) {
                        FriendStatusChecker status = FriendStatusChecker();

                        return ListTile(
                          onTap: () => Navigator.push(
                            context,
                            CustomPageRoute(
                              child: ExternalProfilePage(userModel: results[i]),
                            ),
                          ),
                          leading: CircleAvatar(
                            backgroundColor: Colors.white,
                            backgroundImage:
                                const AssetImage('images/User.png'),
                            foregroundImage: (results[i].photo_url != null)
                                ? NetworkImage(results[i].photo_url!)
                                : null,
                          ),
                          title: NormalText(results[i].name),
                          subtitle: NormalText(
                            results[i].username,
                            fontSize: 12,
                          ),
                        );
                      },
                    ),
                  );
                }),
          if (!expand &&
              query.isNotEmpty &&
              results.isNotEmpty &&
              results.length > 5)
            TextButton(
              onPressed: () {
                expand = true;
                getSearchData();
                setState(() {});
              },
              child: const NormalText('Show More'),
            )
        ],
      ),
    );
  }
}
