import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData prefixIcon;

  final bool obscureText;

  final TextEditingController? controller;

  final TextInputType keyboardType;

  final bool enabled;

  final bool readOnly;

  final bool autofocus;

  final ValueChanged<String>? onChanged;

  final TextInputAction textInputAction;

  final int maxLines;

  const CustomTextField({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    this.obscureText = false,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.enabled = true,
    this.readOnly = false,
    this.autofocus = false,
    this.onChanged,
    this.textInputAction = TextInputAction.next,
    this.maxLines = 1,
  });

  @override
  State<CustomTextField> createState() =>
      _CustomTextFieldState();
}

class _CustomTextFieldState
    extends State<CustomTextField> {
  late bool isHidden;

  @override
  void initState() {
    super.initState();

    isHidden = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,

      obscureText: isHidden,

      keyboardType: widget.keyboardType,

      enabled: widget.enabled,

      readOnly: widget.readOnly,

      autofocus: widget.autofocus,

      onChanged: widget.onChanged,

      textInputAction: widget.textInputAction,

      maxLines:
          widget.obscureText ? 1 : widget.maxLines,

      decoration: InputDecoration(
        hintText: widget.hintText,

        prefixIcon: Icon(
          widget.prefixIcon,
        ),

        suffixIcon: widget.obscureText
            ? IconButton(
                onPressed: () {
                  setState(() {
                    isHidden = !isHidden;
                  });
                },
                icon: Icon(
                  isHidden
                      ? Icons.visibility_off
                      : Icons.visibility,
                ),
              )
            : null,

        filled: true,

        fillColor: widget.enabled
            ? Colors.grey.shade100
            : Colors.grey.shade200,

        contentPadding:
            const EdgeInsets.symmetric(
          vertical: 20,
        ),

        border: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),

        focusedBorder: const OutlineInputBorder(
          borderRadius:
              BorderRadius.all(
            Radius.circular(12),
          ),
          borderSide: BorderSide(
            color: Color(0xFF1296DB),
            width: 1.5,
          ),
        ),

        disabledBorder: OutlineInputBorder(
          borderRadius:
              BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
          ),
        ),
      ),
    );
  }
}