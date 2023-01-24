import 'package:flutter/material.dart';
import 'package:metature2/pages/main_page.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class BottomNavigation extends StatefulWidget {
  const BottomNavigation({
    Key? key,
  }) : super(key: key);


  @override
  State<BottomNavigation> createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {

  @override
  Widget build(BuildContext context) {
    CurIndex curIndex = Provider.of<CurIndex>(context);
    // print(curIndex);
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.red,
        border: Border.symmetric(

          horizontal: BorderSide(color: kPrimaryThemeColor4),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BottomNavOption(
            onTap: () {
              setState(() {
                // curIndex = 0;
                curIndex.changeTo(0);
                // widget.getCurIndex(0);
              });
            },
            imagePath: 'images/home.png',
            isCurIndex: curIndex.curIndex == 0,
          ),
          BottomNavOption(
            onTap: () {
              setState(() {
                curIndex.changeTo(1);
                // curIndex = 1;
                // widget.getCurIndex(1);
              });
            },
            imagePath: 'images/no_notification.png',
            isCurIndex: curIndex.curIndex == 1,
          ),
          BottomNavOption(
            onTap: () {
              setState(() {
                curIndex.changeTo(2);
                // curIndex = 2;
                // widget.getCurIndex(2);
              });
            },
            imagePath: 'images/User.png',
            isCurIndex: curIndex.curIndex == 2,
          ),
          BottomNavOption(
            onTap: () {
              setState(() {
                // curIndex = 3;
                curIndex.changeTo(3);
                // widget.getCurIndex(3);
              });
            },
            imagePath: 'images/settings.png',
            isCurIndex: curIndex.curIndex == 3,
          ),
        ],
      ),
    );
  }
}

class BottomNavOption extends StatelessWidget {
  const BottomNavOption({
    Key? key,
    required this.onTap,
    required this.imagePath,
    required this.isCurIndex,
  }) : super(key: key);
  final VoidCallback? onTap;
  final String imagePath;
  final bool isCurIndex;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: kPrimaryThemeColor1,
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(7),
                  color: kPrimaryThemeColor4,
                ),
                height: isCurIndex ? 3 : 0,
                width: isCurIndex ? MediaQuery.of(context).size.width / 8 : 0,
              ),
              const SizedBox(
                height: 8.5,
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                curve: Curves.easeOut,
                height: isCurIndex ? 25 : 28,
                child: Image.asset(
                  imagePath,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}