import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import '../../../core/utils/function/shared_preferance_utils.dart';
import '../../../core/utils/storage_key.dart';

part 'surah_state.dart';

class SurahCubit extends Cubit<SurahState> {
  SurahCubit() : super(SurahInitial()) {
    audioPlayer = AudioPlayer();
  }
  static SurahCubit get(context) => BlocProvider.of(context);
  double size = 21;
  getFontSize() async {
    size = double.parse(PreferenceUtils.getString(StorageKey.fontSize, "21"));

    emit(GetFontSizeState());
  }

  AudioPlayer? audioPlayer;

  play(url) async {
    emit(StartAudioState());

    if (audioPlayer!.playing) {
      await audioPlayer!.stop();
    }
    await audioPlayer!.setUrl(url);

    await audioPlayer!.play();

    emit(PlayAudioState());
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
}
