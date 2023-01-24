import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:metature2/pages/bottom%20navigation%20routes/Feed.dart';

import '../../components/colored_text.dart';
import '../../components/progress_circle.dart';
import '../../models/group_model.dart';

CollectionReference _user = FirebaseFirestore.instance.collection('user');
CollectionReference _groups = FirebaseFirestore.instance.collection('groups');
final _auth = FirebaseAuth.instance;

class GroupList extends StatefulWidget {
  const GroupList({super.key});

  @override
  State<GroupList> createState() => _GroupListState();
}

class _GroupListState extends State<GroupList> {
  @override
  Widget build(BuildContext context) {
    Query<GroupModel> groupCollection = _groups
        .where('members', arrayContains: _auth.currentUser!.uid)
        .withConverter<GroupModel>(
            fromFirestore: (snapshot, options) =>
                GroupModel.fromJSON(snapshot.data()!),
            toFirestore: (group, setOptions) => group.toJSON());
    return FirestoreListView(
        query: groupCollection,
        loadingBuilder: (context) => const ProgressCircle(),
        itemBuilder: (context, groupModel) {
          final GroupModel groupsData = groupModel.data();
          MessageInfoGroup messageInfoQuery = MessageInfoGroup(
            receiverUid: _auth.currentUser!.uid,
            isSent: true,
            isSeen: true,
          );
          return StreamBuilder<QuerySnapshot<GroupMessageModel>>(
              stream: _groups
                  .doc(groupModel.id)
                  .collection('messages')
                  .withConverter<GroupMessageModel>(
                    fromFirestore: (snapshot, options) =>
                        GroupMessageModel.fromJSON(snapshot.data()!),
                    toFirestore: (groupMessage, setOptions) => groupMessage.toJSON(),
                  )
                  .snapshots(includeMetadataChanges: true),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  int noOfMessages = 0;
                  var lastMessage = (snapshot.data!.size != 0) ? snapshot.data!.docs.last.data() : null;
                  for (var message in snapshot.data!.docs.map((e) => e.data())) {
                    for (var info in message.messageInfo) {
                      if (info.receiverUid == _auth.currentUser!.uid) {
                        if(!info.isSeen) {
                          noOfMessages++;
                        }
                        break;
                      }
                    }
                  }
                  return ListTile(
                    onTap: () {},
                    leading: CircleAvatar(
                      backgroundColor: Colors.white,
                      backgroundImage: const AssetImage('images/User.png'),
                      foregroundImage: (groupModel.exists &&
                              groupsData.groupIconLink != null)
                          ? NetworkImage(groupsData.groupIconLink!)
                          : null,
                    ),
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        NormalText(groupsData.groupName),
                        CircleAvatar(
                          child: NormalText('$noOfMessages'),
                        )
                      ],
                    ),
                    subtitle: NormalText(
                      lastMessage?.message ?? ' ',
                      fontSize: 12,
                    ),
                  );
                }
                return ProgressCircle();
              });
        });
  }
}
