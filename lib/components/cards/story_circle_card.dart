import 'package:flutter/material.dart';

import '../../constants.dart';
import '../colored_text.dart';

class StoryCircleCard extends StatelessWidget {
  const StoryCircleCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height: 70,
                width: 70,
                decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        kSecondaryThemeColor4,
                        kPrimaryThemeColor4,
                        kSecondaryThemeColor3,
                        kPrimaryThemeColor3,
                        kPrimaryThemeColor4,
                        kSecondaryThemeColor4,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(40)),
              ),
              Container(
                height: 64,
                width: 64,
                decoration: BoxDecoration(
                    color: kPrimaryThemeColor1,
                    borderRadius: BorderRadius.circular(40)),
              ),
              Container(
                height: 62,
                width: 62,
                decoration: BoxDecoration(
                    // color: Colors.white,
                    image: const DecorationImage(
                        image: AssetImage('images/User.png')),
                    borderRadius: BorderRadius.circular(30)),
              ),
            ],
          ),
          const NormalText(
            'Your Story',
            fontSize: 12,
          ),
        ],
      ),
    );
  }
}
