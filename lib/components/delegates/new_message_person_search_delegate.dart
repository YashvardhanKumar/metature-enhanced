import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../SearchAlgo.dart';
import '../../models/profile_model.dart';
import '../../pages/UserProfileOthers.dart';
import '../../pages/bottom navigation routes/Feed.dart';
import '../../pages/chat page/chat_screen.dart';
import '../colored_text.dart';
import '../custom_page_route.dart';
import '../progress_circle.dart';

CollectionReference _user = FirebaseFirestore.instance.collection('user');
FirebaseAuth _auth = FirebaseAuth.instance;

class NewMessagePersonSearchPage extends StatefulWidget {
  const NewMessagePersonSearchPage({Key? key}) : super(key: key);

  @override
  State<NewMessagePersonSearchPage> createState() =>
      _NewMessagePersonSearchPageState();
}

class _NewMessagePersonSearchPageState
    extends State<NewMessagePersonSearchPage> {
  String query = '';
  List<int> indexes = [];
  List<UserModel> usersSelected = [];
  // Timer? timer;

  TextEditingController queryController = TextEditingController();

  bool showLoading = false;
  bool expand = false;

  List<UserModel> results = [];
  QuerySnapshot<UserModel>? querySnapshot, querySnapshotInit;

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
  }

  @override
  void initState() {
    _user
        .doc(_auth.currentUser!.uid)
        .collection('friends')
        .limit(60)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
          toFirestore: (users, _) => users.toJson(),
        )
        .get()
        .then((value) => setState(() => querySnapshotInit = value));
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
          (querySnapshot == null && query.isNotEmpty ||
                  querySnapshotInit == null)
              ? const ProgressCircle()
              : Builder(builder: (context) {
                  if (query.isEmpty && querySnapshotInit != null) {
                    print(query);
                    results =
                        querySnapshotInit!.docs.map((e) => e.data()).toList();
                    if (results.isEmpty) {
                      return const Center(
                        child:
                            NormalText('No Friends found, search for anyone!'),
                      );
                    }
                  } else if (results.isEmpty && querySnapshot != null) {
                    return const Center(
                      child: NormalText('No results found'),
                    );
                  }
                  return Expanded(
                    child: ListView.builder(
                      itemCount: results.length,
                      itemBuilder: (_, i) => ListTile(
                        onLongPress: () {
                          if (indexes.contains(i)) {
                            indexes.remove(i);
                            usersSelected.remove(results[i]);
                          } else {
                            indexes.add(i);
                            usersSelected.add(results[i]);
                          }
                          setState(() {});
                        },
                        onTap: () {
                          if (indexes.contains(i)) {
                            indexes.remove(i);
                            usersSelected.remove(results[i]);
                          } else {
                            if (indexes.isNotEmpty) {
                              indexes.add(i);
                              usersSelected.add(results[i]);
                            } else {
                              Navigator.push(
                                context,
                                CustomPageRoute(
                                  child: const ChatScreen(),
                                ),
                              );
                              // chat page
                            }
                          }
                          setState(() {});
                        },
                        leading: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  const AssetImage('images/User.png'),
                              foregroundImage: (results[i].photo_url != null)
                                  ? NetworkImage(results[i].photo_url!)
                                  : null,
                            ),
                            if (indexes.contains(i))
                              Image.asset(
                                'images/check.png',
                                height: 18,
                              ),
                            //Todo: implement search
                          ],
                        ),
                        title: NormalText(results[i].name),
                        subtitle: NormalText(
                          results[i].username,
                          fontSize: 12,
                        ),
                      ),
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
