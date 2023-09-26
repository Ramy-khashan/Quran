part of 'quran_sound_cubit.dart';

abstract class QuranSoundState extends Equatable {
  const QuranSoundState();

  @override
  List<Object> get props => [];
}

class QuranSoundInitial extends QuranSoundState {}

class LoadingQuranSoundState extends QuranSoundState {}

class SuccessGetQuranSoundState extends QuranSoundState {}

class FaildGetQuranSoundState extends QuranSoundState {}
class GetSelectedState extends QuranSoundState {}
