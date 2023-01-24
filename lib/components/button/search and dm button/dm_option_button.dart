import 'package:flutter/material.dart';
import 'package:metature2/constants.dart';

class DMOption extends StatefulWidget {
  const DMOption({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  State<DMOption> createState() => _DMOptionState();
}

class _DMOptionState extends State<DMOption> {
  bool tapped = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: tapped
          ? null
          : () {
              tapped = true;
              setState(() {});
            },
      child: AnimatedContainer(
        // height: 25,
        // width: 25,
        onEnd: () {
          if (tapped) widget.onTap();
          tapped = false;
          setState(() {});
        },
        padding: EdgeInsets.all((tapped) ? 12 : 8),
        // margin: const EdgeInsets.only(right: 5),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(20), bottomRight: Radius.circular(20)),
        ),
        duration: const Duration(milliseconds: 100),
        child: Image.asset('images/send.png'),
      ),
    );
  }
}
