import 'package:flutter/material.dart';

import '../../colored_text.dart';

class AddVideoButton extends StatelessWidget {
  const AddVideoButton({
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
            'images/video_add.png',
            height: 25,
            width: 25,
          ),
          SizedBox(
            width: 8,
          ),
          Image.asset(
            'images/image_add.png',
            height: 25,
            width: 25,
          ),
          // const NormalText(
          //   'Video',
          //   fontSize: 13,
          // ),
        ],
      ),
    );
  }
}
