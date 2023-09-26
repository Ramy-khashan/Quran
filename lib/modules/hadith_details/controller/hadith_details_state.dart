part of 'hadith_details_cubit.dart';

sealed class HadithDetailsState extends Equatable {
  const HadithDetailsState();

  @override
  List<Object> get props => [];
}

final class HadithDetailsInitial extends HadithDetailsState {}
final class LoadingHadithsDetailsState extends HadithDetailsState {}
final class GetHadithsDetailsState extends HadithDetailsState {}
final class LoadMoreLoadidngHadithsDetailsState extends HadithDetailsState {}
final class LoadMoreGetHadithsDetailsState extends HadithDetailsState {}
