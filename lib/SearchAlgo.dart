import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'models/profile_model.dart';

class SearchAlgorithm {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late List<UserModel> peopleArray;

  SearchAlgorithm(List<UserModel> strs) {
    peopleArray = strs;
  }

  List<UserModel> searchResult(String query) {
    query = query.trim().toLowerCase();
    List<UserModel> result1 = [];
    List<UserModel> result2 = [];
    print(query);
    for (int j = 0; j < peopleArray.length; j++) {
      UserModel data = peopleArray[j];
      String username = data.username.trim().toLowerCase();
      String name = data.name.trim().toLowerCase();

      if (query.isNotEmpty &&
          (username.contains(query) || name.contains(query)) &&
          _auth.currentUser!.uid != data.uid) {
        if ((username.indexOf(query) == 0) || (name.indexOf(query) == 0)) {
          result1.add(data);
          print(j);
        } else {
          result2.add(data);
          print(j);
        }
      }
    }
    result1.addAll(result2);
    return result1;
  }
}
