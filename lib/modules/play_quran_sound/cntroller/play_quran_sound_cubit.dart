import 'dart:math';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';

import '../../view_quran_list/model/surah_model.dart';
import '../model/page_manager.dart';

part 'play_quran_sound_state.dart';

class PlayQuranSoundCubit extends Cubit<PlayQuranSoundState> {
  PlayQuranSoundCubit() : super(PlayQuranSoundInitial())  ;
  static PlayQuranSoundCubit get(context) => BlocProvider.of(context);

  late int duration = 0;
  late int selectedSongIndex;
  int selectedImage = 1;
  int index = 0;
  String serverLink = "";

  List<SurahModel>? surahs;
  AudioPlayer? audioPlayer;
  double volume = 100;
  String? audioUrl;
  Future<void> init(
      {required String serverLink,
      required int index,
      required List<SurahModel> surahs}) async {
    try {
      this.index = index;
      this.surahs = surahs;
      this.serverLink = serverLink;
    audioPlayer = AudioPlayer();
      await audioPlayer!.setAudioSource(AudioSource.uri(
        Uri.parse((serverLink + surahs[index].url).toString().trim()),
        tag: MediaItem(
          id: Random().nextInt(10000).toString(),
          title: surahs[index].name,
          artUri: Uri.parse(
              "https://firebasestorage.googleapis.com/v0/b/have-fun-a5c87.appspot.com/o/showImage%2Fic_launcher_background.png?alt=media&token=8bb5c4f2-0932-4aac-ad17-2c613b1af909"),
        ),
      ));
      // await audioPlayer
      //     .setUrl((serverLink + surahs[index].url).toString().trim());

      audioPlayer!.playerStateStream.listen((playerState) {
        final isPlaying = playerState.playing;
        final processingState = playerState.processingState;
        if (processingState == ProcessingState.loading ||
            processingState == ProcessingState.buffering) {
          buttonNotifier.value = ButtonState.loading;
          emit(LoadingAudioState());
        } else if (!isPlaying) {
          buttonNotifier.value = ButtonState.paused;
          emit(PausedAudioState());
        } else if (processingState != ProcessingState.completed) {
          buttonNotifier.value = ButtonState.playing;
          emit(PlayingAudioState());
        } else {
          audioPlayer!.seek(Duration.zero);
          audioPlayer!.pause();
          changeSurah(true);
        }
      });
      audioPlayer!.positionStream.listen((position) {
        final oldState = progressNotifier.value;
        progressNotifier.value = ProgressBarState(
          current: position,
          buffered: oldState.buffered,
          total: oldState.total,
        );
      });
      audioPlayer!.bufferedPositionStream.listen((bufferedPosition) {
        final oldState = progressNotifier.value;
        progressNotifier.value = ProgressBarState(
          current: oldState.current,
          buffered: bufferedPosition,
          total: oldState.total,
        );
      });
      audioPlayer!.durationStream.listen((totalDuration) {
        final oldState = progressNotifier.value;
        progressNotifier.value = ProgressBarState(
          current: oldState.current,
          buffered: oldState.buffered,
          total: totalDuration ?? Duration.zero,
        );
      });
      audioPlayer!.play();
      test();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  void seek(Duration position) {
    audioPlayer!.seek(position);
  }

  void play() async {
    await audioPlayer!.play();
  }

  void pause() async {
    await audioPlayer!.pause();
  }

  // void stop() async {
  //   await audioPlayer.stop();
  //   init(audioUrl!);
  // }

  void speed() async {
    await audioPlayer!.setSpeed(2.0);
  }

  test() {
    Duration time = audioPlayer!.duration!;
    duration = time.inSeconds;
    emit(GetDurationState());
  }

  void changeVolume() async {
    emit(PlayQuranSoundInitial());

    await audioPlayer!.setVolume(volume / 100);
    emit(ChangeAudioVolumeState());
  }

  changeSurah(bool isIncrees) async {
    emit(PlayQuranSoundInitial());

    if (isIncrees) {
      if (index < 114) {
        index++;
      }
    } else {
      if (index > 0) {
        index--;
      }
    }
    audioPlayer!.stop();
    audioPlayer!.dispose();
    await init(serverLink: serverLink, index: index, surahs: surahs!);
    emit(ChangeShuraState());
  }

  @override
  Future close() {
    audioPlayer!.stop();
    audioPlayer!.dispose();

    return super.close();
  }

  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.paused);
}
