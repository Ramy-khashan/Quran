import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:just_audio/just_audio.dart';
import 'package:quran_app/core/utils/app_string.dart';

import '../../../core/repository/azkar/azkar_repository_impl.dart';
import '../../../core/utils/function/shared_preferance_utils.dart';
import '../../../core/utils/storage_key.dart';
import '../../azkar/model/azkar_model.dart';

part 'azkar_detailsl_state.dart';

class AzkarDetailsCubit extends Cubit<AzkarDetailslState> {
  AzkarDetailsCubit(this.azkarRepositoryImpl) : super(AzkarDetailslInitial()) {
    audioPlayer = AudioPlayer();
    getEnableEn();
  }
  final AzkarRepositoryImpl azkarRepositoryImpl;
  static AzkarDetailsCubit get(context) => BlocProvider.of(context);
  bool isLoading = false;
  bool isFaild = false;
  List<AzkarModel> azkar = [];
  var hiveBox = Hive.box(AppString.azkarHiveBox);
  getEnableEn() {
    emit(AzkarDetailslInitial());

    isEnableEn =
        PreferenceUtils.getString(StorageKey.azkarEn) == "true" ? true : false;
    emit(GetEnableEnState());
  }

  bool isEnableEn = false;
  changeEnableEn(value) {
    emit(AzkarDetailslInitial());

    isEnableEn = value;
    PreferenceUtils.setString(StorageKey.azkarEn, value.toString());
    emit(SaveEnableEnState());
  }

  int pageIndex = 0;
  getPageIndex(index) {
    emit(AzkarDetailslInitial());

    pageIndex = index;
    emit(GetPageIndex());
  }

  int selectedOne = -1;
  AudioPlayer? audioPlayer;
  play(url, index) async {
    selectedOne = index;
    emit(StartAudioState());

    if (audioPlayer!.playing) {
      await audioPlayer!.stop();
    }
    await audioPlayer!.setUrl(url);

    await audioPlayer!.play();

    emit(PlayAudioState());
  }

  stop() {
    audioPlayer!.stop();
    selectedOne = -1;
    emit(StopAudioState());
  }

  @override
  Future<void> close() async {
    await audioPlayer!.dispose();

    return super.close();
  }

  changeePage({required bool nextPage}) {
    if (nextPage) {
      pageController.nextPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    } else {
      pageController.previousPage(
          duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  PageController pageController = PageController();
  List<int> counterList = [];
  generateList(length) {
    List.generate(length, (index) => counterList.add(0));
    emit(InitialCounterValueState());
  }

  increase({required int index, required int quantity}) {
     emit(InitialIncreaseCounterState());
    if (counterList[index] <quantity) {
      counterList[index] += 1;
    }
    emit(IncreaseCounterState());
  }
}
