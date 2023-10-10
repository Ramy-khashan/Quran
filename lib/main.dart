import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:quran_app/core/widgets/loading_item.dart';
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
      androidShowNotificationBadge: true,
      preloadArtwork: true);
  ErrorWidget.builder = (details) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                  icon: const Icon(
                    FontAwesomeIcons.arrowRight,
                    color: Colors.black,
                  )),
            ),
            body: Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(20),
              child: const SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    LoadingItem(),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "جارٍ تحضير كافة الموارد، يرجى الانتظار لإكمال هذه العملية تستغرق بعض الوقت\nPreparing all resources, Please wait to compelet this process",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                    ),

                    // Text(
                    //   details.exception.toString(),
                    //   textAlign: TextAlign.center,
                    //   style: const TextStyle(fontSize: 22),
                    // )
                  ],
                ),
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
