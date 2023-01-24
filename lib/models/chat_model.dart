import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:metature2/models/profile_model.dart';

import 'friend_model.dart';

class ChatModel extends DB {
  final List<String> members;
  final FriendType friendType;
  final DateTime chatCreated;

  ChatModel({
    required this.members,
    required this.chatCreated,
    required this.friendType,
  });
  ChatModel.fromJSON(Map<String, Object?> json)
      : this(
          members: json['members'] as List<String>,
          chatCreated: (json['chat_created'] as Timestamp).toDate(),
          friendType: stringToEnum(json['friend_type'] as String),
        );
  Map<String, Object?> toJSON() => {
        'members': members,
        'chat_created': Timestamp.fromDate(chatCreated),
        'friend_type': enumToString(friendType),
      };
}

class MessageModel extends DB {
  final String message;
  final String receiverUid, senderUid;
  final bool isReply;
  final String? replyToId;
  final bool isImage, isVideo, isGif;
  final bool isSent, isSeen;
  final bool isTemporaryMessage;
  final DateTime messagedAt, seenAt;

  MessageModel({
    required this.seenAt,
    required this.messagedAt,
    required this.isImage,
    required this.isVideo,
    required this.isGif,
    required this.isSent,
    required this.isSeen,
    required this.isTemporaryMessage,
    required this.receiverUid,
    required this.senderUid,
    required this.message,
    required this.isReply,
    required this.replyToId,
  });

  MessageModel.fromJSON(Map<String, Object?> json)
      : this(
          message: json["message"] as String,
          receiverUid: json["receiver_uid"] as String,
          senderUid: json["sender_uid"] as String,
          isReply: json["is_reply"] as bool,
          replyToId: json["reply_to_id"] as String?,
          isImage: json["is_image"] as bool,
          isVideo: json["is_video"] as bool,
          isGif: json["is_gif"] as bool,
          isSent: json["is_sent"] as bool,
          isSeen: json["is_seen"] as bool,
          isTemporaryMessage: json["is_temporary_message"] as bool,
          messagedAt: (json['messaged_at'] as Timestamp).toDate(),
          seenAt: (json['seen_at'] as Timestamp).toDate(),
        );

  Map<String, Object?> toJSON() => {
        'message': message,
        'receiver_uid': receiverUid,
        'sender_uid': senderUid,
        'is_reply': isReply,
        'reply_to_id': replyToId,
        'is_image': isImage,
        'is_video': isVideo,
        'is_gif': isGif,
        'is_sent': isSent,
        'is_seen': isSeen,
        'is_temporary_message': isTemporaryMessage,
        'messaged_at': Timestamp.fromDate(messagedAt),
        'seen_at': Timestamp.fromDate(seenAt),
      };
}
