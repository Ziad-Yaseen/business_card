import 'package:business_card/app.dart';
import 'package:business_card/core/helpers/prefs_helper.dart';
import 'package:business_card/core/keys/prefs_keys.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PrefsHelper.init();
  // TODO: Remove this line after testing
  PrefsHelper.setBool(PrefsKeys.onboardingDone, false);
  runApp(const BusinessCard());
}
