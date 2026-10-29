import 'package:business_card/app.dart';
import 'package:business_card/core/helpers/prefs_helper.dart';
import 'package:business_card/core/keys/prefs_keys.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsHelper.init();
  // This is for testing purposes only. Remove it in production.
  PrefsHelper.setBool(PrefsKeys.onboardingDone, false);
  runApp(const BusinessCard());
}
