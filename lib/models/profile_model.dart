import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class DB extends ChangeNotifier {
  final auth = FirebaseAuth.instance;
  final db = FirebaseFirestore.instance;
  late final CollectionReference _user = db.collection('user');
  bool isOnline = false;

  DB() {
    // db.clearPersistence();
    db.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }
}

class UserModel extends DB {
  final String name, username, uid, email;
  final String? photo_url, bio, website;
  final bool email_verified, presence;
  final DateTime? last_seen;
  final DateTime user_created;

  UserModel({
    required this.user_created,
    required this.email,
    required this.bio,
    required this.website,
    required this.email_verified,
    required this.presence,
    required this.last_seen,
    required this.name,
    required this.username,
    required this.uid,
    required this.photo_url,
  });

  UserModel.fromJson(Map<String, Object?> json)
      : this(
          name: json['name']! as String,
          username: json['username']! as String,
          uid: json['uid']! as String,
          email: json['email']! as String,
          photo_url: json['photo_url'] as String?,
          bio: json['bio'] as String?,
          website: json['website'] as String?,
          email_verified: json['email_verified']! as bool,
          presence: json['presence']! as bool,
          last_seen: (json['last_seen'] as Timestamp?)?.toDate(),
          user_created: (json['user_created'] as Timestamp).toDate(),
        );

  Map<String, Object?> toJson() => {
        'uid': uid,
        'email': email,
        'name': name,
        'photo_url': photo_url,
        'username': username,
        'email_verified': email_verified,
        'bio': bio,
        'website': website,
        'user_created': Timestamp.fromDate(user_created),
        'last_seen':
            (last_seen != null) ? Timestamp.fromDate(last_seen!) : null,
        'presence': presence,
      };

  Map<String, Object?> updates(
          String name, String username, String? website, String? bio) =>
      {
        if (name != this.name) 'name': name,
        if (username != this.username) 'username': username,
        if (website != this.website) 'website': website,
        if (bio != this.bio) 'bio': bio,
      };
}
