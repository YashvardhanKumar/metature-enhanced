import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:metature2/models/friend_model.dart';
import 'package:metature2/models/profile_model.dart';
import 'package:screenshot/screenshot.dart';

class Post extends DB {
  final String? alt;
  final String postUrl;
  final DateTime postDate;
  final String? description;
  final List<FriendType> visibleTo;
  Post({
    required this.description,
    required this.visibleTo,
    required this.postDate,
    required this.postUrl,
    required this.alt,
  });

  Post.fromJson(Map<String, Object?> json)
      : this(
          alt: json['text_of_post'] as String?,
          postUrl: json['post_url'] as String,
          postDate: (json['post_date'] as Timestamp).toDate(),
          description: json['description'] as String?,
          visibleTo: (json['visible_to'] as List<String>)
              .map((e) => stringToEnum(e))
              .toList(),
        );

  Map<String, Object?> toJson() => {
        'text_of_post': alt,
        'post_url': postUrl,
        'post_date': Timestamp.fromDate(postDate),
        'description': description,
        'visibleTo': visibleTo.map((e) => enumToString(e)).toList(),
      };
}

class PostLikes extends DB {
  final List<DocumentReference> likes;
  final DateTime likedAt;

  PostLikes({
    required this.likes,
    required this.likedAt,
  });
}

class PostComment extends DB {
  final List<DocumentReference>? taggedUsers;
  final String commentText;
  final DateTime commentDate;
  final PostComment? replyByCreator;
  final bool likedByCreator;
  final int replyIndent;

  PostComment({
    required this.replyIndent,
    required this.taggedUsers,
    required this.commentText,
    required this.commentDate,
    required this.replyByCreator,
    required this.likedByCreator,
  });

  PostComment.fromJson(Map<String, Object?> json)
      : this(
          taggedUsers: json['tagged_users'] as List<DocumentReference>?,
          commentText: json['comment_text'] as String,
          commentDate: (json['comment_date'] as Timestamp).toDate(),
          replyByCreator: PostComment.fromJson(
              json['reply_by_creator'] as Map<String, Object?>),
          likedByCreator: json['liked_by_creator'] as bool,
          replyIndent: json['reply_indent'] as int,
        );
  Map<String, Object?> toJson() => {
        'tagged_users': taggedUsers,
        'comment_text': commentText,
        'comment_date': Timestamp.fromDate(commentDate),
        'reply_by_creator': replyByCreator?.toJson(),
        'likes_by_creator': replyByCreator,
        'reply_indent': replyIndent,
      };
}
