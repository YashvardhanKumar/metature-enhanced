import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterfire_ui/firestore.dart';
import 'package:metature2/components/custom_page_route.dart';
import 'package:metature2/models/chat_model.dart';
import 'package:metature2/models/friend_model.dart';
import 'package:metature2/models/profile_model.dart';
import 'package:metature2/pages/bottom%20navigation%20routes/Feed.dart';
import 'package:metature2/pages/chat%20page/chat_screen.dart';

import '../../components/colored_text.dart';
import '../../components/progress_circle.dart';

CollectionReference _user = FirebaseFirestore.instance.collection('user');
CollectionReference _chats = FirebaseFirestore.instance.collection('chats');
final _auth = FirebaseAuth.instance;

class ChatList extends StatefulWidget {
  const ChatList({super.key});

  @override
  State<ChatList> createState() => _ChatListState();
}

class _ChatListState extends State<ChatList> {
  Query<ChatModel> chatCollection = _chats
      .where('members', arrayContains: _auth.currentUser!.uid)
      .withConverter<ChatModel>(
          fromFirestore: (snapshot, options) =>
              ChatModel.fromJSON(snapshot.data()!),
          toFirestore: (friends, setOptions) => friends.toJSON());

  @override
  Widget build(BuildContext context) {
    return FirestoreListView(
      query: chatCollection,
      loadingBuilder: (context) => const ProgressCircle(),
      itemBuilder: (context, chatModel) {
        final chatModelData = chatModel.data();
        final personUid = (chatModelData.members[0] == _auth.currentUser!.uid)
            ? chatModelData.members[0]
            : chatModelData.members[1];
        DocumentReference<UserModel> personProfileDocument =
            _user.doc(personUid).withConverter<UserModel>(
                  fromFirestore: (snapshot, options) =>
                      UserModel.fromJson(snapshot.data()!),
                  toFirestore: (friend, setOptions) => friend.toJson(),
                );
        return StreamBuilder<DocumentSnapshot<UserModel>>(
            stream:
                personProfileDocument.snapshots(includeMetadataChanges: true),
            builder: (context, snapshot) {
              bool hasData = snapshot.hasData;
              final UserModel? personProfile =
                  (hasData) ? snapshot.data!.data()! : null;
              return StreamBuilder<QuerySnapshot<MessageModel>>(
                  stream: chatModel.reference
                      .collection('messages')
                      .limit(1)
                      .withConverter<MessageModel>(
                        fromFirestore: (snapshot, options) =>
                            MessageModel.fromJSON(snapshot.data()!),
                        toFirestore: (message, setOptions) => message.toJSON(),
                      )
                      .snapshots(includeMetadataChanges: true),
                  builder: (context, snapshot2) {
                    MessageModel? message = snapshot2.data?.docs.first.data();
                    return ListTile(
                      onTap: () {
                        Navigator.push(
                          context,
                          CustomPageRoute(child: const ChatScreen()),
                        );
                      },
                      leading: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: const AssetImage('images/User.png'),
                        foregroundImage:
                            (hasData && personProfile!.photo_url != null)
                                ? NetworkImage(personProfile.photo_url!)
                                : null,
                      ),
                      title: NormalText(personProfile?.name),
                      subtitle: NormalText(
                        message?.message ?? '',
                        fontSize: 12,
                      ),
                      trailing: NormalText(
                        '${message?.messagedAt.hour}:${message?.messagedAt.minute}',
                      ),
                    );
                  });
            });
      },
    );
  }
}
