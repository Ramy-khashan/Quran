import 'package:flutter/material.dart';
import 'core/utils/function/shared_preferance_utils.dart';

import 'core/utils/service_locator.dart';
import 'quran.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await serviceLocator();

  runApp(const QuranApp());
}
