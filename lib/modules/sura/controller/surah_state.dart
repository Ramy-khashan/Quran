part of 'surah_cubit.dart';

abstract class SurahState extends Equatable {
  const SurahState();

  @override
  List<Object> get props => [];
}

class SurahInitial extends SurahState {}
class ChangeFontState extends SurahState {} 
class ChangeShowFontState extends SurahState {}
class GetFontSizeState extends SurahState {}
class StartAudioState extends SurahState {}
class PauseFullAudioState extends SurahState {}
class PlayFullAudioState extends SurahState {}
class PlayAudioState extends SurahState {}
class SaveEnableEnState extends SurahState {} 
class GetEnableEnState extends SurahState {} 
