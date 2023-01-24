import 'package:flutter/material.dart';
import 'package:flutter/src/animation/animation_controller.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/ticker_provider.dart';
import 'package:metature2/constants.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: Container(
              // margin: const EdgeInsets.all(10),
              child: ListView.builder(
                itemBuilder: (context, i) => Row(
                  children: [
                    const Expanded(
                      child: SizedBox(),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: (i % 2 == 0) ? 1.5 : 0,
                          bottom: (i % 2 != 0) ? 1.5 : 1),
                      height: 30,
                      width: deviceWidth * (2 / 3),
                      decoration: BoxDecoration(
                        color: kPrimaryThemeColor2,
                        borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular((i % 2 == 0) ? 3 : 15),
                          topLeft: const Radius.circular(15),
                          bottomLeft: const Radius.circular(15),
                          topRight: Radius.circular((i % 2 != 0) ? 3 : 15),
                        ),
                      ),
                    ),
                  ],
                ),
                itemCount: 50,
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: kPrimaryThemeColor1,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      const BoxShadow(
                          color: kPrimaryThemeColor2,
                          blurRadius: 10,
                          offset: Offset.zero),
                      BoxShadow(
                          color: kPrimaryThemeColor1.withAlpha(60),
                          blurRadius: 10,
                          offset: Offset.zero),
                    ],
                  ),
                  margin: const EdgeInsets.all(8),
                  child: TextField(
                    maxLines: 8,
                    minLines: 1,
                    decoration: InputDecoration(
                      isCollapsed: true,
                      hintText: 'Mesage',
                      // filled: true,
                      contentPadding: const EdgeInsets.all(12),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          width: 1,
                          color: kPrimaryThemeColor2,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                        borderSide: const BorderSide(
                          width: 1,
                          color: kPrimaryThemeColor3,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    color: kSecondaryThemeColor4,
                    gradient: const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [kPrimaryThemeColor1, kPrimaryThemeColor2],
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      const BoxShadow(
                          color: kPrimaryThemeColor2,
                          blurRadius: 16,
                          offset: Offset(4, 4)),
                      const BoxShadow(
                          color: kPrimaryThemeColor1,
                          blurRadius: 16,
                          offset: Offset(-4, -4))
                    ],
                  ),
                  margin: const EdgeInsets.only(top: 8, bottom: 8, right: 8),
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    'images/send.png',
                    height: 25,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
