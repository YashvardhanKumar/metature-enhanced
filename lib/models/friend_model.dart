import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:metature2/models/profile_model.dart';

enum FriendType {
  strangers,
  acquaintances,
  friends,
  closeFriends,
  bestFriends,
  restricted,
}

class FriendModel extends DB {
  final String uid;
  final FriendType friendType;
  final DateTime friendSince;
  final String? chatId;

  FriendModel({
    required this.friendType,
    required this.friendSince,
    required this.chatId,
    required this.uid,
  });

  FriendModel.fromJSON(Map<String, Object?> json)
      : this(
          uid: json['uid'] as String,
          friendType: stringToEnum(json['type'] as String),
          friendSince: (json['friend_since'] as Timestamp).toDate(),
          chatId: json['chat_id'] as String?,
        );

  Map<String, Object?> toJson() => {
        'uid': uid,
        'type': enumToString(FriendType.acquaintances),
        'friends_since': Timestamp.fromDate(friendSince),
        'chat_id': chatId,
      };
}

class FriendRequestModel extends DB {
  final String requestSentToUid;
  final DateTime sentAt;

  FriendRequestModel({
    required this.requestSentToUid,
    required this.sentAt,
  });

  FriendRequestModel.fromJSON(Map<String, Object> json)
      : this(
          requestSentToUid: json["request_sent_to_uid"] as String,
          sentAt: (json["sent_at"] as Timestamp).toDate(),
        );

  Map<String, Object> toJSON() => {
        'request_sent_to_uid': requestSentToUid,
        'sent_at': Timestamp.fromDate(sentAt),
      };
}

FriendType stringToEnum(String type) {
  if (type == 'strangers') {
    return FriendType.strangers;
  }
  if (type == 'acquaintances') {
    return FriendType.acquaintances;
  }
  if (type == 'friends') {
    return FriendType.friends;
  }
  if (type == 'close_friends') {
    return FriendType.closeFriends;
  }
  if (type == 'best_friends') {
    return FriendType.bestFriends;
  }
  return FriendType.restricted;
}

String enumToString(FriendType type) {
  if (type == FriendType.strangers) {
    return 'strangers';
  }
  if (type == FriendType.acquaintances) {
    return 'acquaintances';
  }
  if (type == FriendType.friends) {
    return 'friends';
  }
  if (type == FriendType.closeFriends) {
    return 'close_friends';
  }
  if (type == FriendType.bestFriends) {
    return 'best_friends';
  }
  return 'restricted';
}
