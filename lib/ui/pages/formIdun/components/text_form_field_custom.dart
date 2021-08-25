import 'package:flutter/material.dart';

class TextFormFieldCustom extends StatelessWidget {

  final String? initialValue;
  final String labelText;
  final String? hintText;
  final String? errorText;
  final enabled;
  final onChanged;

  TextFormFieldCustom({required this.labelText, this.initialValue, this.enabled = true, this.hintText, this.errorText, this.onChanged});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      enabled: enabled,
      initialValue: initialValue,
      //style: TextStyle(color: Colors.black.withOpacity(.4)),
      decoration: InputDecoration(
        labelText: labelText,
        hintText: hintText,
        errorText: errorText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
