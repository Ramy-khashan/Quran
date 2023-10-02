import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
 import 'package:quran_app/modules/azkar/model/azkar_model.dart';
import 'package:quran_app/modules/quran_read/model/quran_model.dart';
import 'package:workmanager/workmanager.dart';
import 'core/utils/app_string.dart';
import 'core/utils/function/shared_preferance_utils.dart';
 
import 'core/utils/service_locator.dart';
import 'quran.dart';
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    // Perform your periodic task here.
    // This is where you put your background logic.

    return Future.value(true);
  });
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //  Workmanager().initialize(callbackDispatcher);

  await PreferenceUtils.init();
  await serviceLocator();
  await Hive.initFlutter();
    Hive.registerAdapter(AzkarModelAdapter());
    Hive.registerAdapter(QuranModelAdapter());
 await Hive.openBox<List<AzkarModel>>(AppString.azkarHiveBox);
 await Hive.openBox<List<QuranModel>>(AppString.quranHiveBox);

  runApp(const QuranApp());
}
