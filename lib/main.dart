import 'dart:math';
import 'package:adhan_dart/adhan_dart.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:quran_app/core/data/azkar_data.dart';
import 'package:quran_app/core/widgets/loading_item.dart';
import 'package:quran_app/modules/azkar/model/azkar_model.dart';
import 'package:quran_app/modules/quran_read/model/quran_model.dart';
import 'package:workmanager/workmanager.dart';
import 'package:intl/intl.dart' as intl;
import 'core/notification/notification_services.dart';
import 'core/utils/app_string.dart';
import 'core/utils/function/shared_preferance_utils.dart';
import 'core/utils/service_locator.dart';
import 'core/utils/storage_key.dart';
import 'quran.dart';

const fridayAzkarRemider = "fridayAzkarRemider";
const azkar = "azkar";
const taskAzanFajr = "taskAzanFajr";
const taskAzanDhuhr = "taskAzanDhuhr";
const taskAzanAsr = "taskAzanAsr";
const taskAzanMaghrib = "taskAzanMaghrib";
const taskAzanIsha = "taskAzanIsha";

setAlarm(
    {required int alarmId,
    required DateTime alarmTime,
    required String assetsAudio,
    required String alarmBody}) async {
  // await Alarm.init();
  // // NotificationService().showNotification(alarmId, "Quran", alarmBody);
  // // Fluttertoast.showToast(msg: alarmBody);
  // Fluttertoast.showToast(msg: "test");

  // await Alarm.set(
  //     alarmSettings: AlarmSettings(
  //   id: 1,
  //   dateTime: alarmTime,
  //   assetAudioPath: assetsAudio,
  //   loopAudio: false,
  //   vibrate: true,
  //   volumeMax: true,
  //   fadeDuration: 3.0,
  //   notificationTitle: 'Quran',
  //   notificationBody: alarmBody,
  //   enableNotificationOnKill: true,
  //   stopOnNotificationOpen: true,
  // )).then((value) => log(alarmBody));
}

void callbackDispatcher() async {
  WidgetsFlutterBinding.ensureInitialized();
  await PreferenceUtils.init();
  await NotificationService().initNotification();

  // await Alarm.init();

  double latuitde =
      double.parse(PreferenceUtils.getString(StorageKey.latuitde).toString());
  double longitude =
      double.parse(PreferenceUtils.getString(StorageKey.longitude).toString());

  Coordinates coordinates = Coordinates(latuitde, longitude);
  CalculationParameters params = CalculationMethod.MuslimWorldLeague();

  PrayerTimes prayerTimes = PrayerTimes(
      coordinates, DateTime.now().toLocal(), params,
      precision: true);
  int randomAzkarIndex = Random().nextInt(AzkarData.azkar.length - 1);
  Workmanager().executeTask((taskName, inputData) async {
    switch (taskName) {
      case azkar:
        NotificationService().showNotification(
            randomAzkarIndex, "الأذكار", AzkarData.azkar[randomAzkarIndex]);

        break;
      case fridayAzkarRemider:
        if (intl.DateFormat.E().format(DateTime.now()) == "Fri") {
          if (PreferenceUtils.getString("enter") != "true") {
            NotificationService().initNotification();
            NotificationService().showNotification(559855, "الصلاة علي النبي",
                " اللَّهمَّ صلِّ على محمَّدٍ وعلى آلِ محمَّدٍ كما صلَّيتَ علَى إبراهيمَ وعلَى آلِ إبراهيمَ، وبارِكْ على محمَّدٍ وعلى آلِ محمَّدٍ كما بارَكْتَ على إبراهيمَ وعلى آلِ إبراهيمَ في العالَمينَ إنَّكَ حميدٌ مجيدٌ ");

            NotificationService().showNotification(
                559847,
                "تذكير سورة الكهف",
                "لا تنسي قرأه سورة الكهف فضل قراءة سورة الكهف يوم الجمعة قول النبي -صلى الله عليه وسلم-: (مَن قرأَ سورةَ الكَهْفِ في يومِ الجمعةِ سَطعَ لَهُ نورٌ مِن تحتِ قدمِهِ إلى عَنانِ السَّماءِ، يضيءُ"
                    " لَهُ يومَ القيامةِ، وغُفِرَ لَهُ ما بينَ الجمعتينِ).");
            PreferenceUtils.setString("enter", "true");
          }
        } else {
          PreferenceUtils.setString("enter", "false");
        }
        break;
      case taskAzanFajr:
         // NotificationService().showNotification(11, "Quran", "صلاة الفجر");
        setAlarm(
            alarmId: 0,
            alarmTime: prayerTimes.fajr!.add(const Duration(hours: 2)),
            assetsAudio: 'audio/azan.mp3',
            alarmBody: "صلاة الفجر");

        break;
      case taskAzanDhuhr:
        // Fluttertoast.showToast(msg: "Quran");
        // await Alarm.init();
        // NotificationService().showNotification(12, "Quran", "صلاة الضهر");
        // try{    await Alarm.set(
        //         alarmSettings: AlarmSettings(
        //       id:1,
        //       dateTime: prayerTimes.asr!.add(const Duration(hours: 2)),
        //       assetAudioPath: 'audio/azan.mp3',
        //       loopAudio: false,
        //       vibrate: true,
        //       volumeMax: true,
        //       fadeDuration: 3.0,
        //       notificationTitle: 'Quran',
        //       notificationBody: "صلاة الضهر",
        //       enableNotificationOnKill: true,
        //       stopOnNotificationOpen: true,
        //     )).then((value) => log("صلاة الضهر"));}catch(e){
        //       log(e.toString());
        // }
        // setAlarm(
        //     alarmId: 1,
        //     alarmTime: prayerTimes.dhuhr!.add(const Duration(hours: 2)),
        //     assetsAudio: 'audio/azan.mp3',
        //     alarmBody: "صلاة الضهر");

        break;
      case taskAzanAsr:
        // Fluttertoast.showToast(msg: "Quran");
        // NotificationService().showNotification(13, "Quran", "صلاة العصر");
        // Alarm.isRinging(1);
        // try{  Alarm.set(
        //       alarmSettings: AlarmSettings(
        //     id: 2,
        //     dateTime: prayerTimes.asr!.add(const Duration(hours: 2)),
        //     assetAudioPath: 'audio/azan.mp3',
        //     loopAudio: false,
        //     vibrate: true,
        //     volumeMax: true,
        //     fadeDuration: 3.0,
        //     notificationTitle: 'Quran',
        //     notificationBody: "صلاة العصر",
        //     enableNotificationOnKill: true,
        //     stopOnNotificationOpen: true,
        //   )).then((value) => log("صلاة العصر"));}catch(e){
        //     log(e.toString());
        //   }
        Fluttertoast.showToast(msg: "LOLLLLL");

        break;
      case taskAzanMaghrib:
          setAlarm(
            alarmId: 3,
            alarmTime: prayerTimes.maghrib!.add(const Duration(hours: 2)),
            assetsAudio: 'audio/azan.mp3',
            alarmBody: "صلاة المغرب");

        break;
      case taskAzanIsha:
         setAlarm(
            alarmId: 4,
            alarmTime: prayerTimes.isha!.add(const Duration(hours: 2)),
            assetsAudio: 'audio/azan.mp3',
            alarmBody: "صلاة العشاء");

        break;
    }
    // AudioPlayer audioPlayer = AudioPlayer();
    // await audioPlayer.setAsset('audio/azan.mp3');
    // await audioPlayer.play();

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
  await Workmanager().initialize(callbackDispatcher, isInDebugMode: false);
  // await NotificationService().initNotification();
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
