import 'package:flutter/material.dart';

class ButtonLogin extends StatelessWidget {
  final Function onPressed;
  final Color buttonColor;
  final Color textColor;
  final String text;
  const ButtonLogin({
    Key? key,
    required this.onPressed,
    required this.buttonColor,
    required this.textColor,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
          primary: buttonColor,
          padding: const EdgeInsets.symmetric(
              horizontal: 50,
              vertical: 20
          ),
        ),
        onPressed: onPressed(),
        child:  Text(
          text,
          style: TextStyle(
              color: textColor
          ),
        )
    );
  }
}
