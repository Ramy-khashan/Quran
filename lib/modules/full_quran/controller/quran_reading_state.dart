part of 'quran_reading_cubit.dart';

abstract class FullQuranReadingState extends Equatable {
  const FullQuranReadingState();

  @override
  List<Object> get props => [];
}

class QuranReadingInitial extends FullQuranReadingState {}
class GetSurahNameState extends FullQuranReadingState {}
