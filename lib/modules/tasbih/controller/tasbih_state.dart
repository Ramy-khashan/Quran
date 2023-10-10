part of 'tasbih_cubit.dart';

sealed class TasbihState extends Equatable {
  const TasbihState();

  @override
  List<Object> get props => [];
}

final class TasbihInitial extends TasbihState {}

final class OnPressDownState extends TasbihState {}

final class OnPressUpState extends TasbihState {}
final class GetTasbihValuesState extends TasbihState {}
final class ResetTasbihState extends TasbihState {}
