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
import '../../full_quran/view/full_quran_screen.dart';
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

  updateLoation() async {
    await determinePosition().then((value) async {
      latuitde = value.latitude;
      longitude = value.longitude;
      await getPrayTime();
      await PreferenceUtils.setString(StorageKey.latuitde, latuitde.toString());
      await PreferenceUtils.setString(
          StorageKey.longitude, longitude.toString());
    });
  }

  getLocationAndPrayTime() async {
    if (latuitde == null && longitude == null ||
        latuitde == 0 && longitude == 0) {
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

    Coordinates coordinates = Coordinates(latuitde!, longitude!);
    CalculationParameters params = CalculationMethod.muslimWorldLeague();

    PrayerTimes prayerTimes = PrayerTimes(
        coordinates: coordinates,
        date: DateTime.now().toLocal(),
        calculationParameters: params,
        precision: true);
    prayerTimes.nextPrayer();

    prayTime = prayerTimes;
    prayTimeList = [
      PrayTimeModel(
          time: DateFormat.jm("ar")
              .format(prayerTimes.fajr!.add(const Duration(hours: 2))),
          img: AppAssets.fajrImage,
          prayTitle: "الفجر"),
      PrayTimeModel(
          time: DateFormat.jm("ar")
              .format(prayerTimes.dhuhr!.add(const Duration(hours: 2))),
          img: AppAssets.dhuhrImage,
          prayTitle: "الظهر"),
      PrayTimeModel(
          time: DateFormat.jm("ar")
              .format(prayerTimes.asr!.add(const Duration(hours: 2))),
          img: AppAssets.asrImage,
          prayTitle: "العصر"),
      PrayTimeModel(
          time: DateFormat.jm("ar")
              .format(prayerTimes.maghrib!.add(const Duration(hours: 2))),
          img: AppAssets.maghribImage,
          prayTitle: "المغرب"),
      PrayTimeModel(
          time: DateFormat.jm("ar")
              .format(prayerTimes.isha!.add(const Duration(hours: 2))),
          img: AppAssets.ishaImage,
          prayTitle: "العشاء"),
    ];

    // nextPray();
    isLoading = false;
    emit(GetPrayTimeState());
  }

  nextPray() {
    try {
      if (prayTime!.currentPrayer(date: DateTime.now()) == Prayer.fajr) {
        time = prayTime!.sunrise!.difference(DateTime.now());
        pray = "Sunrise";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) ==
          Prayer.sunrise) {
        time = prayTime!.dhuhr!.difference(DateTime.now());
        pray = "Dhuhr";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) ==
          Prayer.dhuhr) {
        time = prayTime!.asr!.difference(DateTime.now());
        pray = "Asr";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) == Prayer.asr) {
        time = prayTime!.maghrib!.difference(DateTime.now());
        pray = "Maghrib";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) ==
          Prayer.maghrib) {
        time = prayTime!.isha!.difference(DateTime.now());
        pray = "Isha";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) == Prayer.isha) {
        time = prayTime!.fajrafter!.difference(DateTime.now());
        pray = "Fajr";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) ==
          Prayer.ishaBefore) {
        time = prayTime!.dhuhr!.difference(DateTime.now());
        pray = "Dhuhr";
      } else if (prayTime!.currentPrayer(date: DateTime.now()) == Prayer.none) {
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
    FeatureModel(
      name: "القرأن",
      image: "logo.png",
      page: const FullQuranScreen(),
    ),
    FeatureModel(
      name: "تعلم القرأن",
      image: "quran.png",
      page: const QuranScreen(),
    ),
    FeatureModel(
      name: "سماع القرأن",
      image: "quran_voice.png",
      page: const QuranSoundScreen(),
    ),
    FeatureModel(
      name: "القبله",
      image: "qibla.png",
      page: const QiblahCompassScreen(),
    ),
  ];
}
