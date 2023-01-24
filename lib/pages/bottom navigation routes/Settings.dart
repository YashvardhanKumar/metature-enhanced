import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:metature2/pages/bottom%20navigation%20routes/Feed.dart';

import '../../components/bottom_navigation.dart';
import '../../components/cards/post_card.dart';
import '../../components/colored_text.dart';
import '../../components/sticky_sliver.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double maxHeight = size.height -
        MediaQuery.of(context).padding.top -
        MediaQuery.of(context).padding.bottom;
    return Scaffold(
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          title: NormalText('Settings', fontSize: 24)),
      body: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: 4 + 1,
        itemBuilder: (BuildContext context, int index) {
          return PostCard();
        },
      ),
    );
  }
}
