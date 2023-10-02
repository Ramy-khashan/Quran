import 'dart:async';

import 'package:adhan_dart/adhan_dart.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:quran_app/modules/quran_read/view/quran_screen.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/function/shared_preferance_utils.dart';
import '../../../core/utils/storage_key.dart';

import '../../../core/utils/function/get_location.dart';
import '../../qiblah/view/qiblah_screen.dart';
import '../../quran_sound/view/quran_soun_screen.dart';
import '../model/feature_model.dart';
import '../model/pray_time_model.dart';

part 'homepage_state.dart';

class HomepageCubit extends Cubit<HomepageState> {
  HomepageCubit() : super(HomepageInitial());
  static HomepageCubit get(context) => BlocProvider.of(context);
  double? latuitde;
  double? longitude;
 
  DateTime dateTime = DateTime.now();
  timeStream() {
    Timer.periodic(const Duration(seconds: 1), (timer) {
      emit(StartDateTimeState());

      dateTime = DateTime.now();
      emit(ChangeDateTimeState());
    });
  }

  Duration? time;
  getSavedLocation() async {
    
    latuitde =
        double.parse(PreferenceUtils.getString(StorageKey.latuitde, "0"));
    longitude =
        double.parse(PreferenceUtils.getString(StorageKey.longitude, "0"));
 
  }

  getLocationAndPrayTime() async {
    if (latuitde == null && longitude == null||latuitde==0&&longitude==0) {
      await determinePosition().then((value) async {
        latuitde = value.latitude;
        longitude = value.longitude;

        await getPrayTime();
        PreferenceUtils.setString(StorageKey.latuitde, latuitde.toString());
        PreferenceUtils.setString(StorageKey.longitude, longitude.toString());
      });
    } else {
      await getPrayTime();
    }
  }

  List<PrayTimeModel> prayTimeList = [];
  bool isLoading = false;
  PrayerTimes? prayTime;
  getPrayTime() async {
    isLoading = true;
    emit(LoadingGetPrayTimeState());

    Coordinates coordinates = Coordinates(latuitde, longitude);
    CalculationParameters params = CalculationMethod.MuslimWorldLeague();

    PrayerTimes prayerTimes =
        PrayerTimes(coordinates, DateTime.now(), params, precision: true);
    prayerTimes.nextPrayer();

    prayTime = prayerTimes;
    prayTimeList = [
      PrayTimeModel(
          time: DateFormat.jm()
              .format(prayerTimes.fajr!.add(const Duration(hours: 3))),
          img: AppAssets.fajrImage,
          prayTitle: "Fajr"),
      PrayTimeModel(
          time: DateFormat.jm()
              .format(prayerTimes.dhuhr!.add(const Duration(hours: 3))),
          img: AppAssets.dhuhrImage,
          prayTitle: "Dhuhr"),
      PrayTimeModel(
          time: DateFormat.jm()
              .format(prayerTimes.asr!.add(const Duration(hours: 3))),
          img: AppAssets.asrImage,
          prayTitle: "Asr"),
      PrayTimeModel(
          time: DateFormat.jm()
              .format(prayerTimes.maghrib!.add(const Duration(hours: 3))),
          img: AppAssets.maghribImage,
          prayTitle: "Maghrib"),
      PrayTimeModel(
          time: DateFormat.jm()
              .format(prayerTimes.isha!.add(const Duration(hours: 3))),
          img: AppAssets.ishaImage,
          prayTitle: "Isha"),
    ];
    // final dio = Dio();
    // //http://api.aladhan.com/v1/timings/${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}?latitude=$latuitde&longitude=$longitude&method=2
    // dio.interceptors.add(HttpFormatter());
    // final response = await dio.get(
    //     "http://api.aladhan.com/v1/timings/${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}?latitude=$latuitde&longitude=$longitude&method=2"
    //     // "http://api.aladhan.com/v1/calendar/${DateTime.now().year}/${DateTime.now().month}?latitude=$latuitde&longitude=$longitude&method=2",
    //     );
    nextPray();
    isLoading = false;
    emit(GetPrayTimeState());
  }

  nextPray() {
    try {
      if (prayTime!.currentPrayer(date: DateTime.now()) == Prayer.Fajr) {
        time = prayTime!.sunrise!.difference(DateTime.now());
        pray = "Sunrise";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) ==
          Prayer.Sunrise) {
        time = prayTime!.dhuhr!.difference(DateTime.now());
        pray = "Dhuhr";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) ==
          Prayer.Dhuhr) {
        time = prayTime!.asr!.difference(DateTime.now());
        pray = "Asr";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) == Prayer.Asr) {
        time = prayTime!.maghrib!.difference(DateTime.now());
        pray = "Maghrib";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) ==
          Prayer.Maghrib) {
        time = prayTime!.isha!.difference(DateTime.now());
        pray = "Isha";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) == Prayer.Isha) {
        time = prayTime!.fajrafter!.difference(DateTime.now());
        pray = "Fajr";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) ==
          Prayer.IshaBefore) {
        time = prayTime!.dhuhr!.difference(DateTime.now());
        pray = "Dhuhr";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) == Prayer.None) {
        time = prayTime!.fajr!.difference(DateTime.now());
        pray = "Fajr";
      }
      remainMinute = (time!.inMinutes % 60);
      remainHour = (((time!.inMinutes - remainMinute) / 60) - 2).ceil();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  int remainHour = 0;
  int remainMinute = 0;
  String pray = "";

  List<FeatureModel> feature = [
    FeatureModel(name: "Quran", image: "quran.png", page: const QuranScreen()),
    FeatureModel(
        name: "Quran Voice",
        image: "quran_voice.png",
        page: const QuranSoundScreen()),
    FeatureModel(
        name: "Qibla", image: "qibla.png", page: const QiblahCompassScreen()),
  ];
}
