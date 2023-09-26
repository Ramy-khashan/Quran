part of 'prayers_cubit.dart';

sealed class PrayersState extends Equatable {
  const PrayersState();

  @override
  List<Object> get props => [];
}

final class PrayersInitial extends PrayersState {}

final class OnPressDownState extends PrayersState {}

final class OnPressUpState extends PrayersState {}
final class GetPrayersValuesState extends PrayersState {}
