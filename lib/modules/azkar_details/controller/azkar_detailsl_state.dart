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
 