import 'package:flutter/material.dart';

import '../../../constants.dart';
import 'add_status_button.dart';
import 'add_feed_post_button.dart';

class AddPostButton extends StatelessWidget {
  const AddPostButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.all(6),
      // padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(7),
        color: kPrimaryThemeColor2,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const AddVideoButton(),
          Container(
            height: 25,
            width: 0.5,
            color: kSecondaryThemeColor1,
          ),
          const AddStatusButton(),
        ],
      ),
    );
  }
}
