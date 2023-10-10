import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:quran_app/modules/azkar/model/azkar_model.dart';
import 'package:quran_app/modules/quran_read/model/quran_model.dart';
import 'package:workmanager/workmanager.dart';
import 'core/utils/app_string.dart';
import 'core/utils/function/shared_preferance_utils.dart';
import 'package:just_audio_background/just_audio_background.dart';

import 'core/utils/service_locator.dart';
import 'quran.dart';

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
    await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
    androidShowNotificationBadge: true,preloadArtwork: true
  );
  ErrorWidget.builder = (details) => MaterialApp(
    debugShowCheckedModeBanner: false,
    theme: ThemeData(useMaterial3: true),
        home: Scaffold(
          backgroundColor: const Color.fromARGB(255, 255, 196, 0),
          body: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.warning,
                    color: Colors.white,
                    size: 80,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    details.exception.toString(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 22),
                  )
                ],
              ),
            ),
          ),
        ),
      );
  
  //  Workmanager().initialize(callbackDispatcher);
  await initializeDateFormatting("ar", null);

  // Intl.defaultLocale = 'ar';
  await PreferenceUtils.init();
  await serviceLocator();
  await Hive.initFlutter();
  Hive.registerAdapter(AzkarModelAdapter());
  Hive.registerAdapter(QuranModelAdapter());
  await Hive.openBox<List<AzkarModel>>(AppString.azkarHiveBox);
  await Hive.openBox<List<QuranModel>>(AppString.quranHiveBox);

  runApp(const QuranApp());
}
