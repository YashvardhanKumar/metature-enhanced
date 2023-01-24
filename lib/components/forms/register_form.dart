
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:metature2/components/custom_page_route.dart';
import 'package:metature2/pages/username_page.dart';

import '../../constants.dart';
import '../button/Custombutton.dart';
import '../button/google_sign_in_buttons.dart';
import '../colored_text.dart';
import '../text_field.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class RegisterForm extends StatefulWidget {
  const RegisterForm({Key? key}) : super(key: key);

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String? name;
  String? emailID;
  String? password;
  String? confirmPassword;
  bool showLoading = false;
  bool isValidEmail = true;
  bool usedEmail = false;
  bool validPassword = false;
  final _formKey = GlobalKey<FormState>();
  final nameCtrl = TextEditingController();
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final confPasswordCtrl = TextEditingController();

  void signUp() async {
    try {
      setState(() => showLoading = true);
      await _auth
          .createUserWithEmailAndPassword(
        email: emailID!,
        password: password!,
      )
          .then((value) => setState(() => showLoading = false))
          .then((value) {
        _auth.currentUser!.updateDisplayName(name!.trim());
      }).then((value) {
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushReplacement(
          context,
          CustomPageRoute(
            child: const UsernamePage(),
          ),
        );
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        setState(() => showLoading = false);
        setState(() => isValidEmail = false);
        _formKey.currentState!.validate();
      }
      else if (e.code == 'email-already-in-use') {
        setState(() => showLoading = false);
        setState(() => usedEmail = true);
        _formKey.currentState!.validate();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AutofillGroup(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 7,
            ),
            const NormalText(
              'Sign Up',
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: kPrimaryThemeColor4,
            ),
            const SizedBox(
              height: 7,
            ),
            const GoogleSignInButton(),
            const Divider(
              thickness: 1,
              indent: 20,
              endIndent: 20,
              color: kPrimaryThemeColor3,
            ),
            Column(
              children: [
                CustomTextFormField(
                  keyboardType: TextInputType.name,
                  textCapitalization: TextCapitalization.words,
                  controller: nameCtrl,
                  // autoFillHints: const [AutofillHints.username],
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6), topRight: Radius.circular(6)),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() => name = value),
                  hintText: 'Name',
                ),
                const Divider(
                  height: 0,
                  thickness: 0.5,
                  indent: 20,
                  endIndent: 20,
                  color: kPrimaryThemeColor4,
                ),
                CustomTextFormField(
                  controller: emailCtrl,
                  autoFillHints: const [AutofillHints.email,AutofillHints.username],
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email ID is required';
                    } else {
                      if (!isValidEmail) {
                        emailCtrl.clear();
                        setState(() => isValidEmail = true);
                        return 'Not a Valid Email';
                      } else if (usedEmail) {
                        emailCtrl.clear();
                        passwordCtrl.clear();
                        confPasswordCtrl.clear();
                        nameCtrl.clear();
                        setState(() => usedEmail = false);
                        return 'Account already exists!';
                      }
                      return null;
                    }
                  },
                  onChanged: (value) => setState(() => emailID = value),
                  hintText: 'Email',
                ),
                const Divider(
                  height: 0,
                  thickness: 0.5,
                  indent: 20,
                  endIndent: 20,
                  color: kPrimaryThemeColor4,
                ),
                CustomTextFormField(
                  controller: passwordCtrl,
                  keyboardType: TextInputType.visiblePassword,
                  autoFillHints: const [AutofillHints.password],
                  validator: (value) {
                    RegExp moreThan8 = RegExp(r'.{8,}$');
                    RegExp chars = RegExp(
                        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~])');
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    } else {
                      if (!moreThan8.hasMatch(value)) {
                        return 'Password length should be more than 8';
                      } else if (!chars.hasMatch(value)) {
                        return 'Password must contain capital & small letters, numbers & special characters';
                      } else {
                        return null;
                      }
                    }
                  },
                  onChanged: (value) => setState(() => password = value),
                  onEditingComplete: () => TextInput.finishAutofillContext(),
                  isPassword: true,
                  hintText: 'Password',
                ),
                const Divider(
                  height: 0,
                  thickness: 0.5,
                  indent: 20,
                  endIndent: 20,
                  color: kPrimaryThemeColor4,
                ),
                CustomTextFormField(
                  controller: confPasswordCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Confirm your password';
                    } else {
                      if (password != confirmPassword) {
                        confPasswordCtrl.clear();
                        return 'Password not matching';
                      }
                      return null;
                    }
                  },
                  onChanged: (value) => setState(() => confirmPassword = value),
                  isPassword: true,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6)),
                  hintText: 'Confirm Password',
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            CustomButton(
              onPressed: showLoading
                  ? null
                  : () {
                if (_formKey.currentState!.validate()) {
                  signUp();
                }
              },
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 24,
              child: Stack(
                alignment: Alignment.centerLeft,
                children: [
                  if (showLoading)
                    Container(
                      height: 45,
                      width: 45,
                      padding: const EdgeInsets.all(9.0),
                      child: const CircularProgressIndicator(
                        color: kSecondaryThemeColor2,
                        strokeWidth: 1,
                      ),
                    ),
                  const Center(
                    child: NormalText(
                      "Sign Up",
                      color: kSecondaryThemeColor4,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 7,
            ),
          ],
        ),
      ),
    );
  }
}

//showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (_) => AlertDialog(
//         actionsOverflowAlignment: OverflowBarAlignment.center,
//         backgroundColor: kGreenThemeColor2,
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//         title: const NormalText(
//           'Verify Email',
//           color: kGreenThemeColor4,
//           fontWeight: FontWeight.w500,
//           fontSize: 25,
//         ),
//         content: const NormalText(
//           'An email is sent to your registered Email ID, click it to verify your account',
//           color: kBlueThemeColor2,
//         ),
//         actions: [
//           CustomButton(
//               child: const NormalText(
//                 'Okay',
//                 color: kBlueThemeColor4,
//               ),
//               onPressed: () {
//                 Navigator.pop(context);
//                 Navigator.pushReplacement(
//                     context, CustomPageRoute(child: const UsernamePage()));
//               }),
//         ],
//       ),
//     );
