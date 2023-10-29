part of 'settings_cubit.dart';

sealed class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object> get props => [];
}

final class SettingsInitial extends SettingsState {}
final class SetAzanState extends SettingsState {}
final class StartCancelState extends SettingsState {}
final class CancelState extends SettingsState {}
final class GetActiveNotificationState extends SettingsState {}
final class SetFridayAzkarState extends SettingsState {}

