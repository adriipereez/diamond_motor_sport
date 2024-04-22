import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hintText;
  final int? maxLines;

  const CustomTextField(
      {Key? key, required this.controller, this.hintText, this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: maxLines,
      controller: controller,
      cursorColor: const Color.fromARGB(255, 255, 17, 0),
      style: const TextStyle(
        color: Color.fromARGB(255, 255, 255, 255),
      ),
      decoration: InputDecoration(
        errorStyle: const TextStyle(
          color: Color.fromARGB(255, 255, 255, 255),
          fontStyle: FontStyle.italic,
          fontWeight: FontWeight.bold,
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Color.fromARGB(255, 255, 17, 0),
          ),
        ),
        border: const OutlineInputBorder(borderSide: BorderSide()),
        filled: true,
        fillColor: const Color.fromARGB(200, 22, 21, 21),
        labelText:
            hintText, // Utiliza el valor de hintText como el texto del label
        labelStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w100,
          letterSpacing: 2,
        ),
      ),
    );
  }
}
