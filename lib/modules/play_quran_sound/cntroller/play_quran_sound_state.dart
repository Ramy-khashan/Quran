part of 'play_quran_sound_cubit.dart';

abstract class PlayQuranSoundState extends Equatable {
  const PlayQuranSoundState();

  @override
  List<Object> get props => [];
}

class PlayQuranSoundInitial extends PlayQuranSoundState {}
class PlayingAudioState extends  PlayQuranSoundState {}
class PausedAudioState extends  PlayQuranSoundState {}
class GetDurationState extends  PlayQuranSoundState {}
class GetRandomImageState extends  PlayQuranSoundState {}
class ChangeAudioVolumeState extends  PlayQuranSoundState {}
class LoadingAudioState extends  PlayQuranSoundState {}
class ChangeShuraState extends  PlayQuranSoundState {}
