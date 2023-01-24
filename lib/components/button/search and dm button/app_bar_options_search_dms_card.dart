import 'package:flutter/material.dart';
import 'package:metature2/components/custom_page_route.dart';

import '../../../constants.dart';
import '../../../pages/chat page/chat_page.dart';
import 'dm_option_button.dart';
import 'search_option.dart';

class AppBarOptionSearchDms extends StatelessWidget {
  const AppBarOptionSearchDms({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 39,
      decoration: BoxDecoration(
          color: kPrimaryThemeColor1, borderRadius: BorderRadius.circular(50)),
      // padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
      child: Row(
        children: [
          const SearchOption(),
          const VerticalDivider(
            width: 2,
            color: kSecondaryThemeColor1,
            indent: 7,
            endIndent: 7,
          ),
          DMOption(
            onTap: () => Navigator.of(context)
                .push(CustomPageRoute(child: const ChatPage())),
          ),
        ],
      ),
    );
  }
}
