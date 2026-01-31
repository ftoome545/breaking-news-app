import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.onSaved,
    required this.hintText,
    required this.keyboardType,
  });

  final void Function(String?)? onSaved;
  final String? hintText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.next,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'This field is required';
        } else {
          return null;
        }
      },
      onSaved: onSaved,
      obscureText: false,
      keyboardType: keyboardType,
      decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: Colors.white,
                width: 4,
              )),
          hintText: hintText),
    );
  }
}
