import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metature2/components/colored_text.dart';
import 'package:metature2/pages/username_page.dart';
import 'package:provider/provider.dart';

import '../../change notifiers/google_sign_in.dart';
import '../../constants.dart';
import '../../pages/main_page.dart';
import '../custom_page_route.dart';
import 'Custombutton.dart';

CollectionReference<Map<String, dynamic>> _user =
    FirebaseFirestore.instance.collection('user');
FirebaseAuth _auth = FirebaseAuth.instance;

class GoogleSignInButton extends StatefulWidget {
  const GoogleSignInButton({
    Key? key,
  }) : super(key: key);

  @override
  State<GoogleSignInButton> createState() => _GoogleSignInButtonState();
}

class _GoogleSignInButtonState extends State<GoogleSignInButton> {
  bool? newUser;

  @override
  Widget build(BuildContext context) {
    return CustomButton(
        colorString: kSecondaryThemeColor1.value,
        onPressed: () async {
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          bool proceed = await provider.googleLogin();
          if (proceed) {
            _user
                .where('uid', isEqualTo: _auth.currentUser!.uid)
                .get()
                .then((value) {
              if (value.size == 0) {
                setState(() => newUser = true);
              } else {
                setState(() => newUser = false);
              }
              if (newUser != null && newUser!) {
                Navigator.pushReplacement(
                    context, CustomPageRoute(child: const UsernamePage()));
              } else {
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
                Navigator.pushReplacement(
                    context, CustomPageRoute(child: const MainPage()));
              }
            });

          }
        },
        width: MediaQuery.of(context).size.width - 24,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("images/Google.png"),
            ),
            const Center(
              child: NormalText(
                "Login with Google",
                color: kSecondaryThemeColor4,
              ),
            ),
          ],
        ));
  }
}
