import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
 import 'package:quran_app/modules/azkar/model/azkar_model.dart';
import 'core/utils/app_string.dart';
import 'core/utils/function/shared_preferance_utils.dart';

import 'core/utils/service_locator.dart';
import 'quran.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await serviceLocator();
  await Hive.initFlutter();
    Hive.registerAdapter(AzkarModelAdapter());
 await Hive.openBox<List<AzkarModel>>(AppString.azkarHiveBox);

  runApp(const QuranApp());
}
