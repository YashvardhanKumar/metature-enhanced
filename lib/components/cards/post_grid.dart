import 'package:flutter/material.dart';

class PostGrid extends StatelessWidget {
  const PostGrid({Key? key, required this.clicked}) : super(key: key);
  final bool clicked;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(1.0),
      child: (clicked)
          ? null
          : Image.asset(
        'images/girl_sample_post.png',
        fit: BoxFit.fitWidth,
      ),
    );
  }
}