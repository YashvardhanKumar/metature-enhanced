import 'package:flutter/material.dart';

import '../cards/post_grid.dart';

class ProfilePostGrid extends StatelessWidget {
  const ProfilePostGrid({
    Key? key,
    this.idx,
    this.onTap,
  }) : super(key: key);
  final VoidCallback? onTap;
  final int? idx;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
      ),
      itemCount: 24,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: onTap,
          child: PostGrid(clicked: index == (idx ?? -1)),
        );
      },
    );
  }
}
