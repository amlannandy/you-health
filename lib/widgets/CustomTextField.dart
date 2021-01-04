import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool obscureText;
  final TextInputType inputType;
  final bool isEnabled;

  CustomTextField({
    @required this.controller,
    @required this.labelText,
    @required this.icon,
    this.obscureText = false,
    this.inputType = TextInputType.text,
    this.isEnabled = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: 10,
        left: 10,
        right: 10,
        bottom: 10,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: TextField(
          style: TextStyle(
            fontFamily: 'Varela',
          ),
          keyboardType: inputType,
          obscureText: obscureText,
          controller: controller,
          enabled: isEnabled,
          decoration: InputDecoration(
            hintText: labelText,
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).accentColor,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).accentColor,
                width: 1.5,
              ),
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(5.0),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 20,
            ),
          ),
        ),
      ),
    );
  }
}
