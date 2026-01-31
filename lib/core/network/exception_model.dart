import 'package:flutter/widgets.dart';

class ExceptionModel {
  final String message;
  final IconData icon;
  final int statusCode;
  ExceptionModel(
      {required this.message, required this.icon, required this.statusCode});
}
