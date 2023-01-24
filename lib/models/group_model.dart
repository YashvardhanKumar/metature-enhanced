import 'package:cloud_firestore/cloud_firestore.dart';

import 'profile_model.dart';

class GroupModel extends DB {
  final List<String> members;
  final DateTime groupCreated;
  final String groupName;
  final String? groupDescription;
  final String groupCreatorUid;
  final List<String> groupAdminsUid;
  final String? groupIconLink;

  GroupModel({
    required this.groupIconLink,
    required this.groupCreated,
    required this.groupName,
    required this.groupDescription,
    required this.groupCreatorUid,
    required this.groupAdminsUid,
    required this.members,
  });
  GroupModel.fromJSON(Map<String, Object?> json)
      : this(
          members: json['members'] as List<String>,
          groupCreated: (json['group_created'] as Timestamp).toDate(),
          groupName: json['group_name'] as String,
          groupDescription: json['group_description'] as String?,
          groupAdminsUid: json['group_admins_uid'] as List<String>,
          groupCreatorUid: json['group_creator_uid'] as String,
          groupIconLink: json['group_icon_link'] as String,
        );
  Map<String, Object?> toJSON() => {
        'members': members,
        'group_created': Timestamp.fromDate(groupCreated),
        'group_name': groupName,
        'group_description': groupDescription,
        'group_admins_uid': groupAdminsUid,
        'group_creator_uid': groupCreatorUid,
        'group_icon_link': groupIconLink,
      };
}

class GroupMessageModel extends DB {
  final String message;
  final String senderUid;
  final bool isReply;
  final String? replyToId;
  final bool isImage, isVideo, isGif;
  final List<MessageInfoGroup> messageInfo;
  final bool isTemporaryMessage;
  final DateTime messagedAt;

  GroupMessageModel({
    required this.messageInfo,
    required this.messagedAt,
    required this.isImage,
    required this.isVideo,
    required this.isGif,
    required this.isTemporaryMessage,
    required this.senderUid,
    required this.message,
    required this.isReply,
    required this.replyToId,
  });

  GroupMessageModel.fromJSON(Map<String, Object?> json)
      : this(
          message: json["message"] as String,
          senderUid: json["sender_uid"] as String,
          isReply: json["is_reply"] as bool,
          replyToId: json["reply_to_id"] as String?,
          isImage: json["is_image"] as bool,
          isVideo: json["is_video"] as bool,
          isGif: json["is_gif"] as bool,
          isTemporaryMessage: json["is_temporary_message"] as bool,
          messagedAt: (json['messaged_at'] as Timestamp).toDate(),
          messageInfo: (json["message_info"] as List<Map<String, Object>>)
              .map((e) => MessageInfoGroup.fromJSON(e))
              .toList(),
        );

  Map<String, Object?> toJSON() => {
        'message': message,
        'sender_uid': senderUid,
        'is_reply': isReply,
        'reply_to_id': replyToId,
        'is_image': isImage,
        'is_video': isVideo,
        'is_gif': isGif,
        'is_temporary_message': isTemporaryMessage,
        'messaged_at': Timestamp.fromDate(messagedAt),
        'message_info': messageInfo.map((e) => e.toJSON()),
      };
}

class MessageInfoGroup extends DB {
  final String receiverUid;
  final bool isSent, isSeen;

  MessageInfoGroup({
    required this.receiverUid,
    required this.isSent,
    required this.isSeen,
  });

  MessageInfoGroup.fromJSON(Map<String, Object> json)
      : this(
          receiverUid: json['receiver_uid'] as String,
          isSent: json['is_sent'] as bool,
          isSeen: json['is_seen'] as bool,
        );
  Map<String, Object> toJSON() => {
        'receiver_uid': receiverUid,
        'is_sent': isSent,
        'is_seen': isSeen,
      };
}
