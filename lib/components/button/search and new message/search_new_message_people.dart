import 'package:flutter/material.dart';
import 'package:metature2/components/custom_page_route.dart';
import 'package:metature2/components/delegates/profile_search_delegate.dart';

import '../../../constants.dart';
import '../../colored_text.dart';

class SearchForNewMessage extends StatelessWidget {
  const SearchForNewMessage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context, CustomPageRoute(child: ProfilePageSearchPage()));
      },
      child: Row(
        children: [
          Image.asset(
            'images/search.png',
            height: 25,
          ),
          const SizedBox(
            width: 10,
          ),
          const NormalText(
            'Search',
            fontSize: 14,
            color: kSecondaryThemeColor2,
          ),
        ],
      ),
    );
  }
}
