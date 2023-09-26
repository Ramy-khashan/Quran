part of 'homepage_cubit.dart';

abstract class HomepageState extends Equatable {
  const HomepageState();

  @override
  List<Object> get props => [];
}

class HomepageInitial extends HomepageState {}
class GetPrayTimeState extends HomepageState {}
class ChangeTimeState extends HomepageState {}
class StartDateTimeState extends HomepageState {}
class ChangeDateTimeState extends HomepageState {}
class LoadingGetPrayTimeState extends HomepageState {}
