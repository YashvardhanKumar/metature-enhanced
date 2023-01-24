import 'package:flutter/material.dart';
import 'package:metature2/components/custom_page_route.dart';

import '../../../constants.dart';
import '../../colored_text.dart';
import '../../delegates/profile_search_delegate.dart';

class SearchOption extends StatefulWidget {
  const SearchOption({
    Key? key,
  }) : super(key: key);

  @override
  State<SearchOption> createState() => _SearchOptionState();
}

class _SearchOptionState extends State<SearchOption> {
  bool tapped = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapped
          ? null
          : () async {
              tapped = true;
              setState(() {});
            },
      child: AnimatedContainer(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        ),
        padding: EdgeInsets.all(tapped ? 11 : 8),
        duration: const Duration(milliseconds: 100),
        onEnd: () {
          if (tapped) {
            Navigator.push(
              context,
              CustomPageRoute(
                child: const ProfilePageSearchPage(),
              ),
            );
          }
          tapped = false;
          setState(() {});
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
      ),
    );
  }
}
