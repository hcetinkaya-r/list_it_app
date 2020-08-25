import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class SocialLoginButton extends StatelessWidget {
  final String butonText;
  final Color butonColor;
  final Color textColor;
  final double radius;
  final double yukseklik;
  final Widget butonIcon;
  final VoidCallback onPressed;

  const SocialLoginButton(
      {Key key,
      @required this.butonText,
      this.butonColor: Colors.purple,
      this.textColor: Colors.white,
      this.radius: 16,
      this.yukseklik: 50,
      this.butonIcon,
      @required this.onPressed})
      : assert(butonText != null, onPressed != null),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8),
      child: SizedBox(
        height: yukseklik,
        child: RaisedButton(
          onPressed: onPressed,
          color: butonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(radius),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              //Spreads, Collection-if, Collection-for
              if (butonIcon != null) ...[
                butonIcon,
                Text(
                  butonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor),
                ),
                Opacity(opacity: 0, child: butonIcon),
              ],

              if (butonIcon == null) ...[
                Container(),
                Text(
                  butonText,
                  textAlign: TextAlign.center,
                  style: TextStyle(color: textColor),
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
