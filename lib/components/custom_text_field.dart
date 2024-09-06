import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    required this.controller,
    required this.label,
    super.key,
    this.validation,
    this.maxLength = 0,
    this.onTap,
    this.readOnly = false,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validation;
  final int maxLength;
  final void Function()? onTap;
  final bool readOnly;
  final TextInputType? keyboardType;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      onTap: onTap,
      controller: controller,
      keyboardType: keyboardType,
      maxLength: maxLength == 0 ? null : maxLength,
      validator: validation,
      decoration: InputDecoration(
        hintText: label,
        hintStyle: Theme.of(context).textTheme.bodyLarge,
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            width: 2,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: Colors.red, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
