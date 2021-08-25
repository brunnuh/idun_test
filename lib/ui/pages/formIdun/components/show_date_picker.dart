import 'package:flutter/material.dart';

Future<DateTime?> showDatepicker(BuildContext context, DateTime dateTime) async {
  return await showDatePicker(
    context: context,
    initialDate: dateTime,
    firstDate: DateTime(1111),
    lastDate: DateTime(2999),
  );
}