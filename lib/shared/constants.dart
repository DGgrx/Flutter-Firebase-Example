import 'package:flutter/material.dart';

InputDecoration textInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      fillColor: Colors.white.withOpacity(0.3),
      filled: true,
      enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.white.withOpacity(0.1), width: 2.0)),
      focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Colors.brown.withOpacity(0.3), width: 2.0)));
}