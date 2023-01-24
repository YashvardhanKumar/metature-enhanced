import 'package:flutter/material.dart';
import 'package:metature2/components/button/search%20and%20new%20message/NewMessageButton.dart';

import '../../../constants.dart';
import '../search and dm button/search_option.dart';

class AppbarOptionSearchNewMessage extends StatelessWidget {
  const AppbarOptionSearchNewMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      decoration: BoxDecoration(
          color: kPrimaryThemeColor1, borderRadius: BorderRadius.circular(50)),
      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(
        children: const [
          SearchOption(),
          VerticalDivider(
            width: 2,
            color: kSecondaryThemeColor1,
            indent: 7,
            endIndent: 7,
          ),
          NewMessageButton(),
        ],
      ),
    );
  }
}
