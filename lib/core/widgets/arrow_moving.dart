 import 'package:flutter/material.dart';

class ArrowMovingItem extends StatelessWidget {
  const ArrowMovingItem(
      {super.key,
      required this.width,
      required this.height,
      required this.isLeft,
      required this.onTap});
  final double width;
  final double height;
  final bool isLeft;
  final Function() onTap;
  @override
  Widget build(BuildContext context) {
    return Positioned(
        bottom: -15,
        right: isLeft ? null : -15,
        left: isLeft ? -15 : null,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: width,
          height: height,
          decoration: BoxDecoration(
              color: Colors.grey.shade300, shape: BoxShape.circle),
          child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(50),
              child: Icon(
                isLeft ? Icons.arrow_back_ios : Icons.arrow_forward_ios,
                size: 30,
              )),
        ));
  }
}
