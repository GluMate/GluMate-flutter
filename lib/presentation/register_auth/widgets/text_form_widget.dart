import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String>? onChanged;
  final IconData? icon; 

  const CustomTextFormField({
    Key? key,
    required this.label,
    required this.controller,
    this.validator,
    this.onChanged,
    this.icon, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      controller: controller,
      style: TextStyle(color: Colors.black),
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        prefixIcon: icon != null ? Icon(icon, color: Color.fromARGB(218, 91, 169, 233)): null, // Added prefixIcon
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Color.fromARGB(218, 91, 169, 233)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Color.fromARGB(218, 91, 169, 233)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Color.fromARGB(255, 107, 190, 150)),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red),
        ),
        contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
        labelText: label,
        labelStyle: TextStyle(color: Colors.grey),
        errorStyle: TextStyle(color: Colors.red),
      ),
      validator: validator,
      onChanged: onChanged,
    );
  }
}
