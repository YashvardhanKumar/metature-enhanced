import 'package:flutter/material.dart';

import '../components/back_design.dart';
import '../components/forms/login_form.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: (MediaQuery.of(context).size.height * 0.271),
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('images/Logo.png'),
                  ),
                ),
                const BackDesign(
                  ratioHeight: 0.7,
                  child: LoginForm(),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
