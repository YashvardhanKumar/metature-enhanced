import 'package:flutter/material.dart';
import 'package:metature2/components/forms/username_form.dart';

import '../components/back_design.dart';

class UsernamePage extends StatelessWidget {
  const UsernamePage({Key? key}) : super(key: key);

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
                  height: (MediaQuery.of(context).size.height * 0.371),
                  child: Hero(
                    tag: 'logo',
                    child: Image.asset('images/Logo.png'),
                  ),
                ),
                const BackDesign(
                  ratioHeight: 0.6,
                  child: UsernameForm(),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
