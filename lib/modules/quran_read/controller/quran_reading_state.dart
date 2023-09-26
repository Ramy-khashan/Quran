part of 'quran_reading_cubit.dart';

abstract class QuranReadingState extends Equatable {
  const QuranReadingState();

  @override
  List<Object> get props => [];
}

class QuranReadingInitial extends QuranReadingState {}
class GetSurahNameState extends QuranReadingState {}
