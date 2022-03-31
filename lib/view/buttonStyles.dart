import 'package:flutter/material.dart';

//Main Text Button
ButtonStyle mainButtonStyle = ButtonStyle(
  backgroundColor: MaterialStateProperty.all<Color>(Colors.purple),
);
TextStyle mainButtonTextStyle = TextStyle(
  color: Colors.white,
);

TextButton MainTextButton(VoidCallback? onPressed, String buttonText) {
  return TextButton(
    onPressed: onPressed,
    child: Text(
      buttonText,
      style: mainButtonTextStyle,
    ),
    style: mainButtonStyle,
  );
}

//Main Icon Button
//insert Icon Button Styles here
class MainIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget icon;

  const MainIconButton({
    Key? key,
    required this.onPressed,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
    );
  }
}
