import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metature2/components/button/Custombutton.dart';
import 'package:metature2/components/colored_text.dart';
import 'package:metature2/components/custom_page_route.dart';
import 'package:metature2/components/text_field.dart';
import 'package:metature2/models/profile_model.dart';
import 'package:metature2/pages/main_page.dart';

import '../../constants.dart';

CollectionReference<Map<String, dynamic>> _user =
    FirebaseFirestore.instance.collection('user');
FirebaseAuth _auth = FirebaseAuth.instance;

class UsernameForm extends StatefulWidget {
  const UsernameForm({Key? key}) : super(key: key);

  @override
  State<UsernameForm> createState() => _UsernameFormState();
}

class _UsernameFormState extends State<UsernameForm> {
  String? username;
  bool usedUsername = false;
  final _formKey = GlobalKey<FormState>();

  void addUserDataToDB() {
    UserModel? userData = UserModel(
      user_created: Timestamp.now().toDate(),
      email: _auth.currentUser!.email!,
      bio: null,
      website: null,
      email_verified: _auth.currentUser!.emailVerified,
      presence: false,
      last_seen: null,
      name: _auth.currentUser!.displayName!,
      username: username!,
      uid: _auth.currentUser!.uid,
      photo_url: _auth.currentUser!.photoURL,
    );
    _user.where('username', isEqualTo: username).limit(1).get().then(
          (value) => (value.size != 0)
              ? setState(() {
                  usedUsername = true;
                  _formKey.currentState!.validate();
                })
              : _user
                  .doc(_auth.currentUser!.uid)
                  .set(userData.toJson())
                  .then((value) {
                  while (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  Navigator.pushReplacement(
                    context,
                    CustomPageRoute(
                      child: const MainPage(),
                    ),
                  );
                }),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const NormalText(
            'Add Username',
            fontSize: 30,
            fontWeight: FontWeight.w600,
            color: kPrimaryThemeColor4,
          ),
          const Divider(
            thickness: 1,
            indent: 20,
            endIndent: 20,
            color: kPrimaryThemeColor3,
          ),
          CustomTextFormField(
            // value: username,
            inputFormatter: <TextInputFormatter>[
              FilteringTextInputFormatter.allow(RegExp(r'^[a-z_][a-z0-9_]*$'),
                  replacementString: username ?? ''),
            ],
            onChanged: (value) => setState(() => username = value),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Username is Required';
              } else if (usedUsername) {
                setState(() => usedUsername = false);
                return 'Username Already Taken!';
              }
              return null;
            },
            borderRadius: const BorderRadius.all(Radius.circular(6)),
            hintText: 'Username',
          ),
          const SizedBox(
            height: 7,
          ),
          CustomButton(
            onPressed: usedUsername
                ? null
                : () {
                    if (_formKey.currentState!.validate()) addUserDataToDB();
                  },
            width: MediaQuery.of(context).size.width - 24,
            child: const NormalText(
              "Set Username",
              color: kSecondaryThemeColor4,
            ),
          ),
        ],
      ),
    );
  }
}
