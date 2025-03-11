import 'package:final_project/test/di/dependency_injection.dart';
import 'package:final_project/test/main_app.dart';
import 'package:flutter/material.dart';

void main() {
  DependencyInjection.setup();
  runApp(const MainApp());
}
