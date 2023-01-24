import 'package:flutter/material.dart';

class LikeCommentShareOptions extends StatelessWidget {
  const LikeCommentShareOptions({
    Key? key,
    required this.liked
  }) : super(key: key);
  final bool liked;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        LikeButton(liked: liked),
        const SizedBox(
          width: 10,
        ),
        const CommentButton(),
        const SizedBox(
          width: 10,
        ),
        const ShareButton(),
      ],
    );
  }
}

class ShareButton extends StatelessWidget {
  const ShareButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/share.png',
      width: 30,
    );
  }
}

class CommentButton extends StatelessWidget {
  const CommentButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/comment.png',
      width: 30,
    );
  }
}

class LikeButton extends StatelessWidget {
  const LikeButton({
    Key? key, required this.liked,
  }) : super(key: key);
  final bool liked;
  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'images/heart${liked ? '_red' : ''}.png',
      width: 30,
    );
  }
}