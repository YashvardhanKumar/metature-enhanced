import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/friend_model.dart';
import '../models/profile_model.dart';

enum FriendStatus { none, requestReceived, requestSent, friends }

class FriendStatusChecker extends DB {
  Future<FriendStatus> checkFriendStatus(String requestSentToUid) async {
    DocumentReference curUserReference =
        db.collection('user').doc(auth.currentUser!.uid);

    return curUserReference
        .collection('request_sent')
        .doc(requestSentToUid)
        .get()
        .then((value) async {
      print(value.exists);
      if (value.exists) {
        return FriendStatus.requestSent;
      }
      return curUserReference
          .collection('request_received')
          .doc(requestSentToUid)
          .get()
          .then((value) async {
        if (value.exists) {
          return FriendStatus.requestReceived;
        }
        return curUserReference
            .collection('friends')
            .doc(requestSentToUid)
            .get()
            .then((value) {
          if (value.exists) {
            return FriendStatus.friends;
          }
          return FriendStatus.none;
        });
      });
    });
  }

  void sendFriendRequest(FriendRequestModel status) async {
    final curUserDocs = db
        .collection('user')
        .doc(auth.currentUser!.uid)
        .collection('request_sent')
        .doc(status.requestSentToUid);
    final otherUserDocs = db
        .collection('user')
        .doc(status.requestSentToUid)
        .collection('request_received')
        .doc(auth.currentUser!.uid);
    curUserDocs.set(status.toJSON()).then((_) async {
      db.waitForPendingWrites().then(
            (_) async => await curUserDocs.update({
              "sent_at": Timestamp.now(),
            }),
          );
      print(status.requestSentToUid);
      otherUserDocs.set({
        'request_received_from_uid': auth.currentUser!.uid,
        'received_at': status.sentAt
      }).then(
        (value) async => otherUserDocs.update({
          "received_at": Timestamp.now(),
        }),
      );
    });
  }

  void deleteFriendRequest(String requestSentToUid) async {
    final curUserDocs = db.collection('user').doc(auth.currentUser!.uid);
    final otherUserDocs = db.collection('user').doc(requestSentToUid);
    await curUserDocs.collection('request_sent').doc(requestSentToUid).delete();
    otherUserDocs
        .collection('request_received')
        .doc(auth.currentUser!.uid)
        .delete();
  }

  void rejectFriendRequest(String requestSentToUid) async {
    final curUserDocs = db.collection('user').doc(auth.currentUser!.uid);
    final otherUserDocs = db.collection('user').doc(requestSentToUid);
    await curUserDocs
        .collection('request_received')
        .doc(requestSentToUid)
        .delete();
    otherUserDocs
        .collection('request_sent')
        .doc(auth.currentUser!.uid)
        .delete();
  }

  void acceptFriendRequest(FriendRequestModel status) async {
    FriendModel friend = FriendModel(
      friendType: FriendType.strangers,
      friendSince: status.sentAt,
      chatId: null,
      uid: status.requestSentToUid,
    );
    FriendModel you = FriendModel(
      friendType: FriendType.strangers,
      friendSince: status.sentAt,
      chatId: null,
      uid: auth.currentUser!.uid,
    );
    final curUserDocs = db.collection('user').doc(auth.currentUser!.uid);
    final otherUserDocs = db.collection('user').doc(status.requestSentToUid);
    deleteFriendRequest(auth.currentUser!.uid);

    await curUserDocs
        .collection('friends')
        .doc(status.requestSentToUid)
        .set(friend.toJson())
        .then((_) {
      db.waitForPendingWrites().then(
            (_) async => await curUserDocs
                .collection('friends')
                .doc(status.requestSentToUid)
                .update({
              "friend_since": Timestamp.now(),
            }),
          );
      otherUserDocs
          .collection('friends')
          .doc(auth.currentUser!.uid)
          .set(you.toJson())
          .then(
            (value) async => curUserDocs
                .collection('friends')
                .doc(auth.currentUser!.uid)
                .update({
              "friend_since": Timestamp.now(),
            }),
          );
    });
  }

  void removeFriend(String requestSentToUid) async {
    final curUserDocs = db.collection('user').doc(auth.currentUser!.uid);
    final otherUserDocs = db.collection('user').doc(requestSentToUid);

    await curUserDocs.collection('friends').doc(requestSentToUid).delete();
    otherUserDocs.collection('friends').doc(auth.currentUser!.uid).delete();
  }
}
