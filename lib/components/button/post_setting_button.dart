import 'package:flutter/material.dart';

class PostSettingsButton extends StatelessWidget {
  const PostSettingsButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Image.asset(
        'images/post_settings.png',
        height: 25,
      ),
    );
  }
}