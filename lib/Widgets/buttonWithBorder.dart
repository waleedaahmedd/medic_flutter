import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ButtonWithBorder extends StatelessWidget {
  const ButtonWithBorder({
    Key key,
    @required this.text,
    @required this.onPressed,
    //  this.styles = const ButtonStyles(),
  }) : super(key: key);

  final String text;
  final VoidCallback onPressed;

  // final ButtonStyles styles;
  @override
  Widget build(BuildContext context) {
    //  final btnStyles = ButtonStyles();
    return ElevatedButton(
      child: Text(
        '$text',
        style: TextStyle(
            color: Theme.of(context).primaryColor,
            fontSize: 15,
            fontWeight: FontWeight.bold),
      ),
      onPressed: onPressed,
      style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: BorderSide(color: Theme.of(context).primaryColor),
        )),
        backgroundColor: MaterialStateProperty.all(Colors.white),
        padding:
            MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 50.0)),
      ),
      /*
      color: styles.color ?? btnStyles.color,
      colorBrightness: styles.colorBrightness ?? btnStyles.colorBrightness,
      disabledColor: styles.disabledColor ?? btnStyles.disabledColor,
      highlightColor: styles.highlightColor ?? btnStyles.highlightColor,
      padding: styles.padding ?? btnStyles.padding,*/
    );
  }
}

// Styles Class
/*
class ButtonStyles {
  final Color color;
  final Brightness colorBrightness;
  final MaterialColor disabledColor;
  final MaterialColor highlightColor;
  final EdgeInsetsGeometry padding;

  const ButtonStyles({
    this.color = Colors.blue, // set default Values
    this.colorBrightness = Brightness.dark, //
    this.disabledColor = Colors.blueGrey, //
    this.highlightColor = Colors.red, //
    this.padding =
    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5.0), //
  });
}*/
