import 'package:flutter/material.dart';
import 'package:metature2/components/colored_text.dart';
import 'package:metature2/constants.dart';
import 'package:metature2/pages/chat%20page/chat_list.dart';
import 'package:metature2/pages/chat%20page/group_list.dart';

import '../../components/button/search and new message/app_bar_option_search_new_message.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage>
    with SingleTickerProviderStateMixin {
  late TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: dmPageAppbar(_controller),
      backgroundColor: Colors.white,
      body: TabBarView(
        controller: _controller,
        children: const [
          ChatList(),
          GroupList(),
        ],
      ),
    );
  }
}

AppBar dmPageAppbar(TabController controller) {
  return AppBar(
    elevation: 0,
    backgroundColor: Colors.white,
    actions: [],
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(48),
      child: TabBar(
        indicatorColor: kPrimaryThemeColor4,
        labelColor: kPrimaryThemeColor4,
        unselectedLabelColor: kSecondaryThemeColor2,
        controller: controller,
        tabs: [
          const Tab(
            text: 'Chats',
          ),
          const Tab(
            text: 'Groups',
          ),
        ],
      ),
    ),
    title: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const NormalText(
          'Messages',
          fontSize: 20,
        ),
        const AppbarOptionSearchNewMessage(),
      ],
    ),
  );
}



