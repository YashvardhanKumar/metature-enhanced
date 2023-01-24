import 'package:flutter/material.dart';

import '../constants.dart';
import 'colored_text.dart';

class ProfilePicBackground extends StatelessWidget {
  const ProfilePicBackground({Key? key, required this.url}) : super(key: key);
  final String? url;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.hardEdge,
      children: [
        Column(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Image.asset(
                'images/scenery.jpg',
                fit: BoxFit.fitWidth,
              ),
            ),
            Container(
              width: double.infinity,
              color: kPrimaryThemeColor1,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      const SizedBox(
                        width: 120,
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              NormalText(
                                '10K',
                                fontSize: 16,
                              ),
                              NormalText('Friends', fontSize: 12,),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(
                          height: 60,
                          // color: Colors.red,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: const [
                              NormalText(
                                '1000',
                                fontSize: 16,
                              ),
                              NormalText('Posts',fontSize: 12,),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        Column(
          children: [
            const SizedBox(
              height: 140,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white,
                backgroundImage: const AssetImage('images/User.png'),
                foregroundImage: (url != null) ? NetworkImage(url!) : null,
              ),
            ),
          ],
        ),
      ],
    );
  }
}