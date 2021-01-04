import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final String text;
  final Function onPress;
  final Color color;

  const PrimaryButton({
    @required this.text,
    @required this.onPress,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.8,
        child: RaisedButton(
          color: color ?? Theme.of(context).primaryColor,
          onPressed: onPress,
          child: Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Text(
              text.toUpperCase(),
              style: TextStyle(
                fontFamily: 'Lato',
                fontSize: 18,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          textColor: Colors.white.withOpacity(0.9),
        ),
      ),
    );
  }
}
