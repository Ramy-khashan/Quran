import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:quran_app/core/api/dio_consumer.dart';
import 'package:quran_app/core/repository/azkar/azkar_repository_impl.dart';
import 'package:quran_app/core/utils/service_locator.dart';
import 'package:quran_app/modules/azkar/model/azkar_model.dart';
import 'package:quran_app/modules/quran_read/model/quran_model.dart';
import 'core/repository/quran_head_line/quran_impl.dart';
import 'modules/home_page/cubit/homepage_cubit.dart';

import 'config/change_theme/changetheme_cubit.dart';
import 'config/change_theme/changetheme_states.dart';
import 'core/utils/app_string.dart';
import 'modules/splash_screen/view/splash_screen.dart';

class QuranApp extends StatefulWidget {
  const QuranApp({super.key});
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  @override
  State<QuranApp> createState() => _QuranAppState();
}

class _QuranAppState extends State<QuranApp> {
  @override
  void initState() {
    super.initState();
    QuranApp.navigatorKey = GlobalKey<NavigatorState>();
    getQuran();
    getAndSaveLocalData();
  }

  getAndSaveLocalData() async {
    var azkar = Hive.box<List<AzkarModel>>(AppString.azkarHiveBox);

    if (azkar.length < 1) {
      for (int i = 1; i <= 132; i++) {
        if (i == 126) {
          azkar.add([
            AzkarModel(
                iD: 245,
                lANGUAGEARABICTRANSLATEDTEXT: "(La ilaha illal-lah.)",
                rEPEAT: 1,
                tRANSLATEDTEXT:
                    "(None has the right to be worshipped except Allah.)",
                text: "",
                aRABICTEXT: "((لاَ إِلَهَ إِلاَّ اللَّهُ!)).",
                aUDIO: "http://www.hisnmuslim.com/audio/ar/245.mp3")
          ]);
          continue;
        }
        try {
          final response = await AzkarRepositoryImpl(dio: sl.get<DioConsumer>())
              .azkar(azkarId: i, lang: "en");
          response.fold((l) {}, (r) {
            azkar.add(r);
          });
        } catch (e) {
          debugPrint(e.toString());
        }
      }
    }

    await azkar.close();
    await Hive.openBox(AppString.azkarHiveBox);
  }

  getQuran() async {
    var quran = Hive.box<List<QuranModel>>(AppString.quranHiveBox);
    if (quran.length < 1) {
      for (int i = 1; i <= 114; i++) {
        List<QuranModel> quranSurah = await QuranImpl().getQuran(i);
        quran.add(quranSurah);
      }
    }
    await quran.close();
    await Hive.openBox(AppString.quranHiveBox);
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ChangeTheme(),
        ),
        BlocProvider(
            create: (context) => HomepageCubit()
              ..getLocationAndPrayTime()
              ..timeStream()
              ..getSavedLocation()),
      ],
      child: MaterialApp(
        title: AppString.appTitle,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: true,
        ),
        home: BlocBuilder<ChangeTheme, ChangeThemeState>(
          builder: (context, state) {
            return const SplashScreen();
          },
        ),
      ),
    );
  }
}
