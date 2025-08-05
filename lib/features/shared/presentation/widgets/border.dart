import 'package:flutter/material.dart';

InputBorder outlinedBorder({required Color color}) =>
    OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(width: 1.5, color: color),
    );