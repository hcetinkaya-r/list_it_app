import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class PageAvatar extends StatelessWidget {
  final double avatarWidth;
  final double avatarHeight;
  final Color backgroundColor;
  final Color borderColor;
  final Color iconColor;
  final IconData avatarIcon;
  final double iconSize;

  const PageAvatar({
    Key key,
    this.avatarWidth: 60,
    this.avatarHeight: 60,
    this.backgroundColor: Colors.white,
    this.iconColor: const Color(0xFFA30003),
    this.borderColor: const Color(0xFFA30003),
    this.avatarIcon: Icons.person,
    this.iconSize: 55,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: avatarWidth,
      height: avatarHeight,
      decoration: BoxDecoration(
        color: backgroundColor,
        shape: BoxShape.circle,
        border: Border.all(color: borderColor),
      ),
      child: Icon(
        avatarIcon,
        size: iconSize,
        color: iconColor,
      ),
    );
  }
}
