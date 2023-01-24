import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:metature2/change%20notifiers/edit_profile_notifier.dart';
import 'package:metature2/change%20notifiers/edit_text_post_notifier.dart';
import 'package:metature2/models/profile_model.dart';

import '../models/friend_model.dart';
import '../models/post_model.dart';

class PostCRUD extends DB {
  UploadTask? uploadTask;

  Future<UploadTask?> uploadBytes(
      List<String> postVisibility, Uint8List? bytes, String? postText) async {
    final DateTime dateTime = DateTime.now();
    final destination = 'posts/$dateTime';
    try {
      if (bytes != null) {
        uploadTask = FirebaseStorage.instance.ref(destination).putData(bytes);
        print(uploadTask?.snapshot.bytesTransferred);
        print('object uploaded successfully');
      }
      if (uploadTask != null) {
        notifyListeners();
        // while(uploadTask!.snapshot.totalBytes != uploadTask!.snapshot.bytesTransferred) {
        //   print(uploadTask!.snapshot.bytesTransferred);
        // }
        print('object uploaded successfully');
        final snapshot = await uploadTask!.whenComplete(() {});
        final downloadUrl = await snapshot.ref.getDownloadURL();
        // if (downloadUrl) {
        final Post textPost = Post(
          description: null,
          visibleTo: postVisibility.map((e) => stringToEnum(e)).toList(),
          postDate: Timestamp.now().toDate(),
          postUrl: downloadUrl,
          alt: postText,
        );
        await db.collection('post').add(textPost.toJson());
        // }
      }
    } on FirebaseException catch (e) {
      print(e);
    }
    return uploadTask;
  }

  void showUploadTask(UploadTask uploadTask) {}
}
