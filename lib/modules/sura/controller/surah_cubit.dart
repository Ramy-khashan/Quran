import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../../../core/utils/function/shared_preferance_utils.dart';
import '../../../core/utils/storage_key.dart';

part 'surah_state.dart';

class SurahCubit extends Cubit<SurahState> {
  SurahCubit() : super(SurahInitial()) {
    audioPlayer = AudioPlayer();
    audioPlayerAllSurah = AudioPlayer();
    getEnableEn();
    getTafser();
  }
  ScrollController scroll = ScrollController();

  // final String textAr;
  // final String textEn;
  // final String audio;
  // final String audioFile;
  // final String tafser;
  List<AudioSource> surahSoundList = [];
  allSura(List surah, String surahNaem) {
    for (var element in surah) {
      surahSoundList.add(
        AudioSource.uri(
          Uri.parse(
              element.audioFile.isEmpty ? element.audio : element.audioFile),
          tag: MediaItem(
            id: Random().nextInt(10000).toString(),
            title: surahNaem,
            artUri: Uri.parse(
                // sura.audio
                "https://firebasestorage.googleapis.com/v0/b/have-fun-a5c87.appspot.com/o/showImage%2Fic_launcher_background.png?alt=media&token=8bb5c4f2-0932-4aac-ad17-2c613b1af909"),
          ),
        ),
      );
    }
    playAllSurah();
  }

  static SurahCubit get(context) => BlocProvider.of(context);
  double size = 21;
  getFontSize() async {
    size = double.parse(PreferenceUtils.getString(StorageKey.fontSize, "21"));

    emit(GetFontSizeState());
  }

  AudioPlayer? audioPlayer;

  play(sura, title) async {
    isPlaying = false;
    emit(StartAudioState());

    if (audioPlayer!.playing) {
      await audioPlayer!.stop();
    }
    try {
      audioPlayerAllSurah!.stop();
    } catch (e) {
      debugPrint(e.toString());
    }
    await audioPlayer!.setAudioSource(AudioSource.uri(
      Uri.parse(sura.audio),
      tag: MediaItem(
        id: Random().nextInt(10000).toString(),
        title: title,
        artUri: Uri.parse(
            "https://firebasestorage.googleapis.com/v0/b/have-fun-a5c87.appspot.com/o/showImage%2Fic_launcher_background.png?alt=media&token=8bb5c4f2-0932-4aac-ad17-2c613b1af909"),
      ),
    ));

    await audioPlayer!.play();

    emit(PlayAudioState());
  }

  @override
  Future<void> close() async {
    try {
      audioPlayer!.dispose();
      audioPlayerAllSurah!.dispose();
    } catch (e) {
      debugPrint(e.toString());
    }
    return super.close();
  }

  AudioPlayer? audioPlayerAllSurah;
  playAllSurah() async {
    emit(StartAudioState());

    if (audioPlayerAllSurah!.playing) {
      await audioPlayerAllSurah!.stop();
    }
    try {
      audioPlayer!.stop();
    } catch (e) {
      debugPrint(e.toString());
    }
    await audioPlayerAllSurah!
        .setAudioSource(ConcatenatingAudioSource(children: surahSoundList));
    emit(PlayAudioState());
  }

  bool isPlaying = false;
  pauseFullAudio() {
    emit(SurahInitial());
    audioPlayerAllSurah!.pause();
    isPlaying = false;

    emit(PauseFullAudioState());
  }

  playFullAudio() {
    emit(SurahInitial());
    isPlaying = true; 
    audioPlayerAllSurah!.play();

    emit(PlayFullAudioState());
  }

  changeSize(double size) {
    emit(SurahInitial());
    this.size = size;
    PreferenceUtils.setString(StorageKey.fontSize, size.toString());
    emit(ChangeFontState());
  }

  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  bool showChangeFont = false;
  onChangeShowFont(bool show) {
    emit(SurahInitial());

    showChangeFont = show;
    emit(ChangeShowFontState());
  }

  getEnableEn() {
    emit(SurahInitial());

    isEnableEn =
        PreferenceUtils.getString(StorageKey.surahEn) == "true" ? true : false;
    emit(GetEnableEnState());
  }

  bool isEnableEn = false;
  changeEnableEn(value) {
    emit(SurahInitial());

    isEnableEn = value;
    PreferenceUtils.setString(StorageKey.surahEn, value.toString());
    emit(SaveEnableEnState());
  }

  getTafser() {
    emit(SurahInitial());

    istafseer =
        PreferenceUtils.getString(StorageKey.tafseer) == "true" ? true : false;
    emit(GetEnableEnState());
  }

  bool istafseer = false;
  changeTafseer(value) {
    emit(SurahInitial());

    istafseer = value;
    PreferenceUtils.setString(StorageKey.tafseer, value.toString());
    emit(SaveEnableEnState());
  }
}
