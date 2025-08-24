import 'package:flutter/material.dart';

class BMIResultArgs {
  final double bmi;
  final String label;
  final String message;
  final Color color;
  final String gender;
  final int age;
  final double heightIn;
  final double weightKg;

  const BMIResultArgs({
    required this.bmi,
    required this.label,
    required this.message,
    required this.color,
    required this.gender,
    required this.age,
    required this.heightIn,
    required this.weightKg,
  });
}
