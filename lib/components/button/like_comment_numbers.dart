import 'package:flutter/material.dart';

import '../../constants.dart';
import '../colored_text.dart';

class LikeCommentStats extends StatelessWidget {
  const LikeCommentStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const LikeStats(),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 6),
          height: 20,
          width: 0.5,
          color: kSecondaryThemeColor1,
        ),
        const CommentStats(),
      ],
    );
  }
}

class CommentStats extends StatelessWidget {
  const CommentStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        NormalText('1,000'),
        NormalText(
          ' Comments',
          color: kPrimaryThemeColor4,
          fontSize: 12,
        ),
      ],
    );
  }
}

class LikeStats extends StatelessWidget {
  const LikeStats({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        NormalText('15K'),
        NormalText(
          ' Likes',
          color: kSecondaryThemeColor3,
          fontSize: 12,
        ),
      ],
    );
  }
}
