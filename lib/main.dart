import 'package:business_card/app.dart';
import 'package:business_card/core/helpers/prefs_helper.dart';
import 'package:business_card/core/keys/prefs_keys.dart';
import 'package:business_card/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:material_ui/material_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await PrefsHelper.init();
  // Reset onboarding for testing purposes
  PrefsHelper.setBool(PrefsKeys.onboardingDone, false);
  runApp(const BusinessCard());
}
