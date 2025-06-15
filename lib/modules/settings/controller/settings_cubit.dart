import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quran_app/main.dart';
import 'package:workmanager/workmanager.dart';
import '../../../core/utils/function/shared_preferance_utils.dart';
import '../../../core/utils/storage_key.dart';
part 'settings_state.dart';

class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit() : super(SettingsInitial());
  static SettingsCubit getInstance(context) => BlocProvider.of(context);
  bool isFajr = false;
  bool isDhuhr = false;
  bool isAsr = false;
  bool isMaghrib = false;
  bool isIsha = false;
  bool isAzkar = false;
  bool isFridayAzkar = false;
  setAzan({required String uniqueKey, required String taskTitle}) async {
    await [
      Permission.notification,
    ].request();
    bool serviceEnabled;
    LocationPermission permission;
    await Geolocator.requestPermission();

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Fluttertoast.showToast(msg: 'Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Fluttertoast.showToast(
          msg:
              'Location permissions are permanently denied, we can\'t use enable this feature');
    }
    if (permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always) {
      final location = await Geolocator.getCurrentPosition();
      PreferenceUtils.setString(
          StorageKey.latuitde, location.latitude.toString());
      PreferenceUtils.setString(
          StorageKey.longitude, location.longitude.toString());
      changeActive(taskName: taskTitle);

      emit(SettingsInitial());
      await Workmanager().registerPeriodicTask(
        uniqueKey,
        taskTitle,
        constraints: Constraints(
          networkType: NetworkType.connected,
        ),
        frequency: const Duration(days: 1),
      );
      emit(SetAzanState());
    }
  }

  setAzkar({
    required String uniqueKey,
    required String taskTitle,
  }) async {
    await [
      Permission.notification,
    ].request();

    emit(SettingsInitial());
    Platform.isAndroid
        ? await Workmanager()
            .registerPeriodicTask(
              uniqueKey,
              taskTitle,
              constraints: Constraints(
                networkType: NetworkType.connected, // Optional
              ),
              frequency: const Duration(hours: 4),
            )
            .then((value) => changeActive(taskName: taskTitle))
        : Workmanager()
            .registerOneOffTask(
              uniqueKey,
              taskTitle,
              constraints: Constraints(
                networkType: NetworkType.connected, // Optional
              ),
              // frequency: const Duration(hours: 4),
            )
            .then((value) => changeActive(taskName: taskTitle));

    emit(SetAzanState());
  }

  setFridayAzkar(
      {required String uniqueKeyFri, required String taskTitleFri}) async {
    await [
      Permission.notification,
    ].request();

    emit(SettingsInitial());

    Platform.isAndroid
        ? await Workmanager()
            .registerPeriodicTask(
              uniqueKeyFri,
              taskTitleFri,
              constraints: Constraints(
                networkType: NetworkType.connected, // Optional
              ),
              frequency: const Duration(minutes: 15),
            )
            .then((value) => changeActive(taskName: taskTitleFri))
        : await Workmanager()
            .registerOneOffTask(
              uniqueKeyFri,
              taskTitleFri,
              constraints: Constraints(
                networkType: NetworkType.connected, // Optional
              ),
              // frequency: const Duration(minutes: 15),
            )
            .then((value) => changeActive(taskName: taskTitleFri));
    emit(SetFridayAzkarState());
  }

  cancelAzan({required String uniqueKey}) async {
    emit(StartCancelState());
    changeActive(taskName: uniqueKey);
    await Workmanager().cancelByUniqueName(uniqueKey);
    emit(CancelState());
  }

  changeActive({required String taskName}) {
    if (taskName == taskAzanFajr) {
      isFajr = !isFajr;
      PreferenceUtils.setString(
          StorageKey.azanFajrNotification, isFajr.toString());
    } else if (taskName == taskAzanDhuhr) {
      isDhuhr = !isDhuhr;
      PreferenceUtils.setString(
          StorageKey.azanDhuhrNotification, isDhuhr.toString());
    } else if (taskName == taskAzanAsr) {
      isAsr = !isAsr;
      PreferenceUtils.setString(
          StorageKey.azanAsrNotification, isAsr.toString());
    } else if (taskName == taskAzanMaghrib) {
      isMaghrib = !isMaghrib;
      PreferenceUtils.setString(
          StorageKey.azanMaghribNotification, isMaghrib.toString());
    } else if (taskName == taskAzanIsha) {
      isIsha = !isIsha;
      PreferenceUtils.setString(
          StorageKey.azanIshaNotification, isIsha.toString());
    } else if (taskName == azkar) {
      isAzkar = !isAzkar;
      PreferenceUtils.setString(
          StorageKey.azkarNotification, isAzkar.toString());
    } else if (taskName == fridayAzkarRemider) {
      isFridayAzkar = !isFridayAzkar;
      PreferenceUtils.setString(
          StorageKey.azkarNotification, isFridayAzkar.toString());
    }
  }

  getIsActiveNotification() {
    emit(SettingsInitial());
    isFajr =
        PreferenceUtils.getString(StorageKey.azanFajrNotification) == "true"
            ? true
            : false;

    isDhuhr =
        PreferenceUtils.getString(StorageKey.azanDhuhrNotification) == "true"
            ? true
            : false;

    isAsr = PreferenceUtils.getString(StorageKey.azanAsrNotification) == "true"
        ? true
        : false;

    isMaghrib =
        PreferenceUtils.getString(StorageKey.azanMaghribNotification) == "true"
            ? true
            : false;

    isIsha =
        PreferenceUtils.getString(StorageKey.azanIshaNotification) == "true"
            ? true
            : false;

    isAzkar = PreferenceUtils.getString(StorageKey.azkarNotification) == "true"
        ? true
        : false;
    isFridayAzkar =
        PreferenceUtils.getString(StorageKey.fridayAzkarNotification) == "true"
            ? true
            : false;
    emit(GetActiveNotificationState());
  }

  getAlarm() async {
    // await Alarm.init();
    // List<AlarmSettings> alarms = Alarm.getAlarms();
    // print(alarms.length.toString());
    // alarms.forEach((element) {
    //   print(element.id);
    //   print(element.dateTime);
    //   print("-------------------------------------------------");
    // });
  }

  setAlarm(
      {required int alarmId,
      required DateTime alarmTime,
      required String assetsAudio,
      required String alarmBody}) async {
    // await Alarm.init();
    // NotificationService().showNotification(alarmId, "Quran", alarmBody);
    // Fluttertoast.showToast(msg: alarmBody);
    Fluttertoast.showToast(msg: "test");

    // try {
    //   await Alarm.set(
    //       alarmSettings: AlarmSettings(
    //     id: alarmId,
    //     dateTime: alarmTime,
    //     assetAudioPath: assetsAudio,
    //     loopAudio: false,
    //     vibrate: true,
    //     volumeMax: true,
    //     fadeDuration: 3.0,
    //     notificationTitle: 'Quran',
    //     notificationBody: alarmBody,
    //     enableNotificationOnKill: true,
    //     stopOnNotificationOpen: true,
    //   ));
    // } catch (e) {
    //   log(e.toString());
    // }
  }

  yourOnRingCallback() {}
}
