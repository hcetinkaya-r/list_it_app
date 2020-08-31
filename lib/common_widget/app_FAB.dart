import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppFAB extends StatelessWidget {
  final String toolTip;
  final String heroTag;
  final Color backgroundColor;
  final IconData fabIcon;
  final Color iconColor;
  final double iconSize;
  final Color borderColor;
  final double width;
  final double height;
  final VoidCallback onPressed;

  const AppFAB(
      {Key key,
      this.toolTip,
      this.heroTag,
      this.backgroundColor : Colors.white,
      this.fabIcon,
      this.iconColor : Colors.black54,
      this.iconSize : 40,
        this.width,
        this.height,
        this.borderColor : Colors.black38,
      @required this.onPressed})
      : assert(onPressed != null), super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
          border: Border.all(color: borderColor),
      ),
      child: FloatingActionButton(
        onPressed: onPressed,
        tooltip: toolTip,
        heroTag: heroTag,
        backgroundColor: backgroundColor,
        child: Icon(
          fabIcon,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}
