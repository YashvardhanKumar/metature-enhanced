import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:metature2/components/custom_page_route.dart';
import 'package:metature2/components/delegates/new_message_person_search_delegate.dart';
import 'package:metature2/constants.dart';
import 'package:provider/provider.dart';

import '../../../models/profile_model.dart';
import '../../colored_text.dart';

class NewMessageButton extends StatefulWidget {
  const NewMessageButton({
    Key? key,
  }) : super(key: key);

  @override
  State<NewMessageButton> createState() => _NewMessageButtonState();
}

class _NewMessageButtonState extends State<NewMessageButton> {
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return Consumer<UserModel>(
      builder: (_, allProfile, __) => GestureDetector(
        onTap: () async {
          tapped = true;
          setState(() {});
        },
        child: AnimatedContainer(
          duration: Duration(milliseconds: 100),
          onEnd: () {
            if (tapped) {
              Navigator.push(
                context,
                CustomPageRoute(
                  child: NewMessagePersonSearchPage(),
                ),
              );
            }
            tapped = false;
            setState(() {});
          },
          padding: EdgeInsets.all((tapped) ? 12 : 8),
          decoration: const BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
          ),
          child: Image.asset('images/new_message.png'),
        ),
      ),
    );
  }
}

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) =>
            [const SliverAppBar()],
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Material(
                child: Row(
                  children: const [
                    ActionChip(
                        label: NormalText(
                      'Text',
                      color: kPrimaryThemeColor1,
                    ))
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
