part of 'azkar_detailsl_cubit.dart';

  abstract class AzkarDetailslState extends Equatable {
  const AzkarDetailslState();

  @override
  List<Object> get props => [];
}

  class AzkarDetailslInitial extends AzkarDetailslState {}
  class LoadingAzkardetailsState extends AzkarDetailslState {}
  class GetAzkardetailsState extends AzkarDetailslState {}
  class PlayAudioState extends AzkarDetailslState {}
  class StopAudioState extends AzkarDetailslState {}
  class StartAudioState extends AzkarDetailslState {}
  class PausedAudioState extends AzkarDetailslState {}
  class SaveEnableEnState extends AzkarDetailslState {}
  class GetEnableEnState extends AzkarDetailslState {}
  class InitialIncreaseCounterState extends AzkarDetailslState {}
  class IncreaseCounterState extends AzkarDetailslState {}
  class GetPageIndex extends AzkarDetailslState {}
  class InitialCounterValueState extends AzkarDetailslState {}
 
 
 