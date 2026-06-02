import 'package:flutter/material.dart';

class AppInputStyle {

  static InputDecoration decoration({
    required String hint,
    IconData? icon,
  }) {

    return InputDecoration(

      hintText: hint,

      prefixIcon:
          icon != null
              ? Icon(icon)
              : null,

      filled: true,

      fillColor: Colors.white,

      contentPadding:
          const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),

      enabledBorder:
          OutlineInputBorder(

        borderRadius:
            BorderRadius.circular(
          14,
        ),

        borderSide:
            BorderSide(
          color:
              Colors.blue.shade200,
        ),
      ),

      focusedBorder:
          const OutlineInputBorder(

        borderRadius:
            BorderRadius.all(
          Radius.circular(14),
        ),

        borderSide:
            BorderSide(
          color: Color(
            0xFF2D9CDB,
          ),
          width: 2,
        ),
      ),
    );
  }
}