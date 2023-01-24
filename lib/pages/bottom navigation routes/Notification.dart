import 'package:flutter/material.dart';

import '../../components/bottom_navigation.dart';
import '../../components/colored_text.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({Key? key}) : super(key: key);

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
        title: NormalText(
          'Notifications',
          fontSize: 24,
        ),
      ),
      body: Container(
        height: maxHeight - 50,
      ),
    );
  }
}
