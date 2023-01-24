import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:metature2/components/button/Custombutton.dart';
import 'package:metature2/components/colored_text.dart';
import 'package:metature2/components/text_field.dart';

import '../../constants.dart';
import '../../pages/main_page.dart';
import '../button/google_sign_in_buttons.dart';
import '../custom_page_route.dart';

FirebaseAuth _auth = FirebaseAuth.instance;

class LoginForm extends StatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  String? email;
  String? password;
  bool isLoggingIn = false;
  bool isValidEmail = true;
  bool userExists = true;
  bool wrongPassword = false;
  bool forgotPassword = false;
  final _formKey = GlobalKey<FormState>();

  void signIn() async {
    try {
      setState(() => isLoggingIn = true);
      await _auth
          .signInWithEmailAndPassword(email: email!, password: password!)
          .then((value) {
        setState(() => isLoggingIn = false);
        if (Navigator.canPop(context)) {
          Navigator.pop(context);
        }
        Navigator.pushReplacement(
            context, CustomPageRoute(child: const MainPage()));
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        setState(() => isLoggingIn = false);
        setState(() => isValidEmail = false);
        _formKey.currentState!.validate();
      } else if (e.code == 'user-not-found') {
        setState(() => isLoggingIn = false);
        setState(() => userExists = false);
        _formKey.currentState!.validate();
      } else if (e.code == 'wrong-password') {
        setState(() => isLoggingIn = false);
        setState(() => wrongPassword = true);
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
            const NormalText(
              'Login',
              fontSize: 30,
              fontWeight: FontWeight.w600,
              color: kPrimaryThemeColor4,
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
                  keyboardType: TextInputType.emailAddress,
                  autoFillHints: const [AutofillHints.email],
                  controller: emailCtrl,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Email is Required';
                    }
                    if (!isValidEmail) {
                      setState(() => isValidEmail = true);
                      return 'Not a valid Email';
                    }
                    if (!userExists) {
                      setState(() => userExists = true);
                      return 'User doesn\'t exists';
                    }
                    return null;
                  },
                  onChanged: (value) => setState(() => email = value),
                  borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(6),
                      topRight: Radius.circular(6)),
                  hintText: 'Email ID',
                ),
                const Divider(
                  height: 0,
                  thickness: 0.5,
                  indent: 20,
                  endIndent: 20,
                  color: kPrimaryThemeColor4,
                ),
                CustomTextFormField(
                  autoFillHints: const [AutofillHints.password],
                  isPassword: true,
                  controller: passwordCtrl,
                  onChanged: (value) => setState(() => password = value),
                  validator: (value) {
                    if(forgotPassword) return null;
                    if (value == null || value.isEmpty) {
                      return 'Password is required';
                    }
                    if (wrongPassword) {
                      setState(() => wrongPassword = false);
                      return 'Incorrect Password';
                    }
                    return null;
                  },
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(6),
                      bottomRight: Radius.circular(6)),
                  hintText: 'Password',
                ),
              ],
            ),
            const SizedBox(
              height: 7,
            ),
            CustomButton(
              onPressed: isLoggingIn
                  ? null
                  : () {
                      if (_formKey.currentState!.validate()) {
                        signIn();
                      }
                    },
              width: MediaQuery.of(context).size.width - 24,
              child: Stack(
                children: [
                  if (isLoggingIn)
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
                      "Login",
                      color: kSecondaryThemeColor4,
                    ),
                  ),
                ],
              ),
            ),
            CupertinoButton(
              child: const NormalText(
                'Forgot Password?',
                color: kPrimaryThemeColor4,
              ),
              onPressed: () {
                setState(() => forgotPassword = true);
                if(email == null || email == '') {
                  _formKey.currentState?.validate();
                }
                if (email != null) {
                  showDialog(
                    context: context,
                    builder: (_) => const AlertDialog(
                      content: NormalText('Check your email for password reset'),
                    ),
                  );
                  _auth.sendPasswordResetEmail(email: email!);
                }
                // if(isValidEmail)
              },
            ),
          ],
        ),
      ),
    );
  }
}
