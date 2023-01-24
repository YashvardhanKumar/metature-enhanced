import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/profile_model.dart';

class EditProfileNotifier extends DB {
  late DocumentReference<UserModel> userReference;

  EditProfileNotifier() {
    userReference = db
        .collection('user')
        .doc(auth.currentUser!.uid)
        .withConverter<UserModel>(
          fromFirestore: (snapshot, options) =>
              UserModel.fromJson(snapshot.data()!),
          toFirestore: (userData, options) => userData.toJson(),
        );
  }
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final usernameController = TextEditingController();
  final bioController = TextEditingController();
  final websiteController = TextEditingController();

  late String name;
  late String username;
  late String? bio;
  late String? website;
  String? profileUrl;

  bool isLoaded = false, isChanged = false;
  late UserModel user;

  bool? usedUsername;

  void discard() {
    nameController.dispose();
    usernameController.dispose();
    bioController.dispose();
    websiteController.dispose();
  }

  void setUsedUsername(bool value) {
    usedUsername = value;
    notifyListeners();
  }

  void isUsedUsername() {
    if (username != user.username) {
      db
          .collection('user')
          .where('username', isEqualTo: username)
          .limit(1)
          .get()
          .then((value) {
        // print(value.docs.first.data());
        setUsedUsername((value.size != 0) ? true : false);
        formKey.currentState!.validate();
      });
    }
  }

  void setName(String value) {
    name = value;
    notifyListeners();
  }

  void setUsername(String value) {
    username = value;
    notifyListeners();
  }

  void setBio(String value) {
    bio = value;
    notifyListeners();
  }

  void setWebsite(String value) {
    website = value;
    notifyListeners();
  }

  void getDocument() async {
    final userGet = await userReference.get();
    user = userGet.data()!;
    nameController.text = name = user.name;
    usernameController.text = username = user.username;
    bioController.text = bio = user.bio ?? '';
    websiteController.text = website = user.website ?? '';
    profileUrl = user.photo_url;

    isLoaded = true;
    isChanged = (name != user.name ||
        username != user.username ||
        bio != user.bio ||
        website != user.website);
    notifyListeners();
  }

  void updateDocument() async {
    userReference.update(user.updates(name, username, website, bio));
    getDocument();
    notifyListeners();
  }
}
