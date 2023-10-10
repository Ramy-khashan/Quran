part of 'surah_cubit.dart';

abstract class FullQuranSuraState extends Equatable {
  const FullQuranSuraState();

  @override
  List<Object> get props => [];
}

class SurahInitial extends FullQuranSuraState {}
class ChangeFontState extends FullQuranSuraState {} 
class ChangeShowFontState extends FullQuranSuraState {}
class GetFontSizeState extends FullQuranSuraState {}
