import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider extends ChangeNotifier {
  final googleSignIn = GoogleSignIn();

  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  Future<bool> googleLogin() async {
    bool isSignIn = await googleSignIn.isSignedIn();
    if (isSignIn) {
      googleSignIn.signOut();
    }
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) {
      notifyListeners();
      return false;
    }
    _user = googleUser;

    final googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
    notifyListeners();
    return true;
  }

  logout() async {
    if (googleSignIn.currentUser != null) {
      await googleSignIn.disconnect();
      googleSignIn.signOut();
    }
  }
}
