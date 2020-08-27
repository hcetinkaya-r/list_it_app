import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SignInButton extends StatelessWidget {
  final String buttonText;
  final Color buttonColor;
  final Color textColor;
  final double radius;
  final double buttonHeight;
  final Widget buttonIcon;
  final Color borderColor;
  final double borderWidth;
  final double buttonTextSize;
  final VoidCallback onPressed;

  const SignInButton(
      {Key key,
      @required this.buttonText,
      this.buttonColor : Colors.white,
      this.textColor: const Color(0xFFA30003),
      this.radius: 10,
      this.buttonHeight: 50,
      this.buttonIcon,
        this.borderColor : const Color(0xFFA30003),
        this.borderWidth : 2,
        this.buttonTextSize : 24,
      @required this.onPressed})
      : assert(buttonText != null, onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(

      margin: EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: buttonHeight,
        child: RaisedButton(
          onPressed: onPressed,
          color: buttonColor,
          shape: RoundedRectangleBorder(
            side: BorderSide(width: borderWidth, color: borderColor,),
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Spreads, Collection-if, Collection-for
              if (buttonIcon != null) ...[
                buttonIcon,
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor, fontSize: 14),
                ),
                Opacity(opacity: 0, child: buttonIcon),
              ],

              if (buttonIcon == null) ...[
                Container(),
                Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor, fontSize: buttonTextSize),
                ),
                Container(),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

//Eski yöntem
/*
              butonIcon != null ? butonIcon : Container(),
              butonIcon,
              Text(
                butonText,
                style: TextStyle(color: textColor),
              ),
              butonIcon != null
                  ? Opacity(opacity: 0, child: butonIcon)
                  : Container(),
              Opacity(opacity: 0, child: butonIcon),
 */

//Collection-if

/*

              if(butonIcon != null)
                butonIcon,
              Text(
                butonText,
                style: TextStyle(color: textColor),
              ),
              if(butonIcon != null)
                Opacity(opacity: 0, child: butonIcon),
                         if(butonIcon != null)
                Opacity(opacity: 0, child: butonIcon),


 */
