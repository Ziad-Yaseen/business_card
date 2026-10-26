import 'package:business_card/app.dart';
import 'package:business_card/core/helpers/prefs_helper.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsHelper.init();
  runApp(const BusinessCard());
}
