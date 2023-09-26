part of 'hadiths_cubit.dart';

sealed class HadithsState extends Equatable {
  const HadithsState();

  @override
  List<Object> get props => [];
}

final class HadithsInitial extends HadithsState {}
final class GetHadithsState extends HadithsState {}
final class LoadingHadithState extends HadithsState {}
