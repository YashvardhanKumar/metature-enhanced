import 'package:flutter/material.dart';

import '../components/back_design.dart';
import '../components/forms/register_form.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({Key? key}) : super(key: key);

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
                  height: (MediaQuery.of(context).size.height * 0.171),
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('images/Logo.png'),
                  ),
                ),
                const BackDesign(
                  ratioHeight: 0.8,
                  child: RegisterForm(),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
