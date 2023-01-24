import 'package:flutter/material.dart';

import '../../constants.dart';
import '../colored_text.dart';

class PostUserDetail extends StatelessWidget {
  const PostUserDetail({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 12,
          backgroundColor: Colors.white,
          foregroundColor: Colors.white,
          child: Image.asset(
            'images/User.png',
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        const NormalText(
          'just_beyond_selena',
          fontWeight: FontWeight.w500,
          fontSize: 13.5,
        ),
        Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 3),
              decoration: BoxDecoration(
                border: const Border.fromBorderSide(
                  BorderSide(color: kPrimaryThemeColor4),
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const NormalText(
                'Best Friend',
                fontSize: 6,
                color: kPrimaryThemeColor4,
              ),
            ),
            const SizedBox(
              height: 8,
            )
          ],
        ),
      ],
    );
  }
}