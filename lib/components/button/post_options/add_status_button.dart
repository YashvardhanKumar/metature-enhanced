import 'package:flutter/material.dart';

import '../../../constants.dart';
import '../../colored_text.dart';

class AddStatusButton extends StatelessWidget {
  const AddStatusButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset(
            'images/add_story.png',
            height: 25,
            width: 25,
          ),
        ],
      ),
    );
  }
}
