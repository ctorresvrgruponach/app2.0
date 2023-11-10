 import 'package:flutter/material.dart';
 
class InputDecorationBuilder {
  static InputDecoration finalinput({
    required String hintText,
    required String labelText
  }) {
    return InputDecoration(
      border: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
        )
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey, 
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.blue,
          width: 2.0,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(10),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.red,
          width: 2,
        )
      ),
      hintText: hintText,
      labelText: labelText,
      labelStyle: TextStyle(
        color: Color.fromARGB(255, 9, 21, 114),
      ),
    );
  }
}
