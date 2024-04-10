import 'package:flutter/material.dart';

abstract class AppModule {
  void dependencies();

  Map<String, Widget Function(BuildContext context)> routes();
}
